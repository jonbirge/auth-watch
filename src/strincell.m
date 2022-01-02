% -*- texinfo -*- 
% @deftypefn {} {@var{retval} =} contains (@var{input1}, @var{input2})
%
% @seealso{}
% @end deftypefn
%
% Author: Jonathan Birge <birge@mit.edu>
% Created: 2018-08-19

function q = strincell (str, subcell)
  
n = length(subcell);
k = 1;
found = false;
while (~found && k <= n)
  r = regexp(str, subcell{k});
  if ~isempty(r)
    found = true;
  else
    k = k + 1;
  end
end

q = found;

end
