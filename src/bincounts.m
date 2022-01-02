function [relday, cnt] = bincounts (dates, daybins)
  
n = length(dates);
beginbin = floor(daybins*min(dates));
endbin = floor(max(daybins*dates));
relday = transpose(0:(endbin - beginbin - 2));
nbin = length(relday);
cnt = zeros(nbin, 1);
for k = 1:n
  bin = floor(daybins*dates(k));
  if bin > beginbin && bin < endbin
    binidx = bin - beginbin;
    cnt(binidx) = cnt(binidx) + 1;
  end
end

end
