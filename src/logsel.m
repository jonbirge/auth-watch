function dout = logsel(din, procsel, logsel)
% logsel decides what is an intrusion attempt

if nargin < 2
  procsel = 'sshd';
end

if nargin < 3
  logsel = {'Connection closed', 'Received disconnect', ...
    'Disconnecting', 'Disconnected', 'Unable to negotiate'};
end
if isempty(logsel)
  dologsel = false;
else
  dologsel = true;
end

dout = struct();
dout.date = zeros(0, 1);
dout.serv = cell(0, 1);
dout.proc = cell(0, 1);
dout.log = cell(0, 1);
dout.ip = cell(0, 1);
k = 1;
for kin = 1:length(din.date)
  if mod(kin, 100) == 0
    matlog('processing line %d...', kin)
  end
  procstr = din.proc{kin};
  logstr = din.log{kin};
  if strcmp(procsel, procstr)
    if dologsel && any(strincell(logstr, logsel))
      matlog('intrusion attempt detected at line %d!', kin)
      dout.date(k) = din.date(kin);
      dout.serv{k} = din.serv{kin};
      dout.proc{k} = procstr;
      dout.log{k} = logstr;
      dout.ip{k} = din.ip{kin};
      k = k + 1;
    end
  end
end
