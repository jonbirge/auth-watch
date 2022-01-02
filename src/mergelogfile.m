function [dout, newcount, nfound] = mergelogfile(din, authfile)
% [dout, newcount] = MERGELOGFILE(din, authfile)
% where din is a sorted log db and authfile is a string.

if ~isempty(din.date)
  maxdate = max(din.date);
else
  maxdate = 0;  % beginning of time!
end

if nargin < 1
  filename = 'auth.log';
else
  filename = authfile;
end

% read file
fid = fopen(filename);
s = cell(1,1);
lstr = fgetl(fid);
matlog('reading file...')
k = 1;
while lstr ~= -1
  s{k} = lstr;
  k = k + 1;
  lstr = fgetl(fid);
end
fclose(fid);

% parse file & pull novel entries
n = length(s);
dnew.date = [];
dnew.serv = {};
dnew.log = {};
dnew.proc = {};
dnew.ip = {};
matlog('parsing %d lines backwards...', n)
k = length(s);  % go backwards
nfound = 0;
wedone = false;
while ~wedone
  if mod(k, 1000) == 0
    matlog('parsed to line %d...', k)
  end
  
  rawparse = regexp(s{k}, '(^.{15})\s(\S+)\s(\w+).*:\s(.*)', 'tokens');
  parse = rawparse{1};
  curyear = str2double(datestr(now(), 'YYYY'));
  curmonth = str2double(datestr(now(), 'mm'));
  date = datenum(parse{1}, 'mmm dd HH:MM:SS');
  datemonth = str2double(datestr(date, 'mm'));
  if datemonth == 12 && curmonth == 1  % handle New Year's Day corner case
    date = datenum([num2str(curyear - 1) ' ' parse{1}], 'YYYY mmm dd HH:MM:SS');
  end
  if date > maxdate
    nfound = nfound + 1;
    
    ip = regexp(s{k}, '\d+[.]\d+[.]\d+[.]\d+', 'match');
    dnew.date(end + 1) = date;
    dnew.serv{end + 1} = parse{2};
    dnew.proc{end + 1} = parse{3};
    if isempty(parse{4})
      logstr = '';
    else
      logstr = parse{4};
    end
    dnew.log{end + 1} = logstr;
    if isempty(ip)
      dnew.ip{end + 1} = '';
    else
      dnew.ip{end + 1} = ip{1};
    end
    
    k = k - 1;
    if k < 1
      wedone = true;
    end
  else  % we done
    wedone = true;
  end
end
matlog('done at line %d', k);

% filtering
if nfound > 0
  matlog('sorting new entries...')
  dsorted = sortlog(dnew);
  matlog('filtering new entries...')
  dfilt = logsel(dsorted);
  dout.date = [din.date, dfilt.date];
  dout.serv = [din.serv, dfilt.serv];
  dout.proc = [din.proc, dfilt.proc];
  dout.ip = [din.ip, dfilt.ip];
  newcount = length(dfilt.date);
else
  dout = din;
  newcount = 0;
end
