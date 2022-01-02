function dout = parseline(linestr)

s = linestr;

parse = regexp(s, '(^.{15})\s(\S+)\s(\w+).*:\s(.*)', 'tokens');
date = datenum(parse{1}{1}, 'mmm dd HH:MM:SS');
ip = regexp(s, '\d+[.]\d+[.]\d+[.]\d+', 'match');

dout.date = date;
dout.serv = parse{1}{2};
dout.proc = parse{1}{3};
if isempty(parse{1}{4})
  logstr = '';
else
  logstr = parse{1}{4};
end
dout.log = logstr;
if isempty(ip)
  dout.ip = '';
else
  dout.ip = ip{1};
end
  
end