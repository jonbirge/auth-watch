function q = logselq(dline)
% q = logselq(dline) returns a boolean given a single db struct entry

  procsel = 'sshd';
  logsel = {'Connection closed', 'Received disconnect', 'Disconnecting'};

  procstr = dline.proc;
  logstr = dline.log;
  if strcmp(procsel, procstr) && any(strincell(logstr, logsel))
      q = true;
  else
      q = false;
  end
  
end
