function [dout, nfound] = parselogfile(authfile)
%% [dout, newcount] = MERGELOGFILE(din, authfile)
% where din is a sorted log db and authfile is a string.

if nargin < 1
  filename = './auth.log';
else
  filename = authfile;
end

% read file
fid = fopen(filename);
s = cell(1,1);
lstr = fgetl(fid);
fprintf('reading file...\n')
k = 1;
while lstr ~= -1
  s{k} = lstr;
  if mod(k, 10000) == 0
    fprintf('reading line %d...\n', k)
  end
  k = k + 1;
  lstr = fgetl(fid);
end
fclose(fid);

% parse file & pull novel entries
n = length(s);
dnew.date = zeros(1, n);
dnew.serv = cell(1, n);
dnew.proc = cell(1, n);
dnew.log = cell(1, n);
dnew.ip = cell(1, n);
fprintf('parsing %d lines...\n', n)
for k = 1:length(s)
  if mod(k, 1000) == 0
    fprintf('parsed to line %d...\n', k)
  end
  
  parse = regexp(s{k}, '(^.{15})\s(\S+)\s(\w+).*:\s(.*)', 'tokens');
  date = datenum(parse{1}{1}, 'mmm dd HH:MM:SS');
    
  ip = regexp(s{k}, '\d+[.]\d+[.]\d+[.]\d+', 'match');
  dnew.date(k) = date;
  dnew.serv{k} = parse{1}{2};
  dnew.proc{k} = parse{1}{3};
  if isempty(parse{1}{4})
    logstr = '';
  else
    logstr = parse{1}{4};
  end
  dnew.log{k} = logstr;
  if isempty(ip)
    dnew.ip{k} = '';
  else
    dnew.ip{k} = ip{1};
  end
end

% filtering
fprintf('sorting new entries...\n')
dsorted = sortlog(dnew);
fprintf('filtering new entries...\n')
dout = logsel(dsorted);
nfound = length(dout.date);

endfunction
