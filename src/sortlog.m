%  Copyright (C) 2018 Jonathan Birge
%  
%  This program is free software: you can redistribute it and/or modify it
%  under the terms of the GNU General Public License as published by
%  the Free Software Foundation, either version 3 of the License, or
%  (at your option) any later version.
%  
%  This program is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%  
%  You should have received a copy of the GNU General Public License
%  along with this program.  If not, see
%  <https://www.gnu.org/licenses/>.
% 
%  -*- texinfo -*- 
%  @deftypefn {} {@var{retval} =} sortlog (@var{input1}, @var{input2})
% 
%  @seealso{}
%  @end deftypefn
% 
%  Author: Jonathan Birge <jonathan@jonathan-macbook.local>
%  Created: 2018-09-04

function dout = sortlog (din)
  dateraw = din.date;
  [date, k] = sort(dateraw);
  dout.date = date;
  dout.serv = din.serv(k);
  dout.proc = din.proc(k);
  dout.log = din.log(k);
  dout.ip = din.ip(k);
end
