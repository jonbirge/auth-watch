%  Copyright (C) 2018 Jonathan Birge
%
%  Author: Jonathan Birge
%  Created: 2018-09-12
%  TODO: Pull from database or user settings file

function params = getsettings ()
  
  params.logname = '/db/auth.log';
  params.savename = '/db/logdb.mat';
  params.wwwdir = '/www';
  params.email = 'j@birge.us';
  params.daybins = (24*60)/5;  % basic interval

end
