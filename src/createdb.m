function createdb()
  params = getsettings();
  savename = params.savename;

  d.date = zeros(1, 0);
  d.serv = cell(1, 0);
  d.proc = cell(1, 0);
  d.log = cell(1, 0);
  d.ip = cell(1, 0);
  detection = false;
  save(savename, 'd');
end
