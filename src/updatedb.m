% Update DB and compute statistics
% Only script which may write to the database.

clear
matlog('loading database...')
try
  load(getsettings().savename);
catch
  matlog('no db found. creating new one...')
  createdb()
  clear
  load(getsettings().savename)
end

params = getsettings();
savename = params.savename;
logname = params.logname;

%%

matlog('merging newcount log...')
[d, newcount, newlines] = mergelogfile(d, logname);
matlog('found %d new records in %d new log entries', newcount, newlines)

%%

matlog('generating time counts...')
latest = max(d.date);
earliest = min(d.date);
k1 = (latest - d.date) < 1;
d1 = d.date(k1);
d30 = d.date((latest - d.date) < 30);

% bins
daybins = params.daybins;
[day, cnt] = bincounts(d.date, daybins);
[day1, cnt1] = bincounts(d1, daybins);
[day30, cnt30] = bincounts(d30, daybins);

% cfar threshold
matlog('generating statistics...')
maxcnt = max(cnt1);
[b, c] = counthist(cnt, maxcnt);
[b30, c30] = counthist(cnt30, maxcnt);
[b1, c1] = counthist(cnt1, maxcnt);
thi = ceil(mean(cnt30) + std(cnt30)*4);
tlow = floor(mean(cnt30) + std(cnt30)*4);
if cnt1(end) > thi && ~detection
  matlog('*** detection! ***')
  detection = true;
  [ips, ns] = ipcount(d.ip(k1));
  cc = whoisat(ips{1});
  msg = sprintf('Attack detected from %s (%s). %d total attempts in %d min.', ...
    ips{1}, cc, cnt1(end), (24*60)/daybins);
  % syscall = ['echo "', msg, '" | mail -s "Intrusion attempt" ', params.email];
  system(syscall);
else
  matlog('no detection.')
  if cnt1(end) < tlow
    detection = false;
  end
end
detdays = day(cnt > thi);
  
%%

matlog('writing database...')
clear('date', 'dd', 'dds')
save(savename, '-7', 'd*', 'b*', 'c*', 'maxcnt', 't*', 'day*', 'k1');
