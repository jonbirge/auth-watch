% Generate plots

clear
matlog('genplot.m')
matlog('loading file...')
load(getsettings().savename);

params = getsettings();
dirname = params.wwwdir;

% long time series
matlog('time series...')
figure(1, 'visible', 'off')
ndays = floor(length(day)/daybins);
if ndays > 0
  M = reshape(cnt(end-(daybins*ndays)+1:end), daybins, ndays);
  M(M > floor(thi)) = 1000;  % highlight detections
  imagesc(log(transpose(M) + 1))
  title(['Last ', num2str(ndays), ' days'])
  xlabel('Time')
  ylabel('Date')
  axis('tight')
  set(gca, 'fontsize', 14)
  saveas(gcf, [dirname '/hits-all.png']);
end

% day time series
figure(2, 'visible', 'off')
col = [0.4, 0.6, 0.8];
bar(24*day1/daybins - 24, cnt1, ...
    'facecolor', col, 'edgecolor', col);
title(['24 hours from ' datestr(now())])
xlabel('Hour')
axis('tight')
set(gca, 'fontsize', 14)
saveas(gcf, [dirname '/hits-1d.png']);

% distribution
figure(3, 'visible', 'off')
daybins = params.daybins;
plot(b, [c/max(day); c30/max(day30); c1/max(day1)], ...
  '.-', 'linewidth', 8, 'markersize', 12)
set(gca, 'fontsize', 14)
xlim([0, maxcnt]);
title('Hit distribution')
legend('All', '30 days', '1 day')
saveas(gcf, [dirname '/hist.png']);

% ip counts
matlog('ip graph...')
figure(4, 'visible', 'off')
nip = 5;
[ips, ns] = ipcount(d.ip(k1));
iplabs = cell(1,nip);
for k = 1:nip
  cc = whoisat(ips{k});
  iplabs{k} = [ips{k}, ' (', cc, ')'];
end
pie(ns(1:nip), iplabs)
title('Top IPs Last 24 Hours')
saveas(gcf, [dirname '/ips.png']);

% ssi files
f = fopen('/www/detect.ssi', 'w');
if ~isempty(detdays)
  daysincedet = (day(end) - detdays(end))/daybins;
  fprintf(f, '%3.1f days ago (%d total detections)', ...
	  daysincedet, length(detdays));
else
  fprintf(f, 'None');
end
fclose(f);
system('touch /www/index.shtml');
