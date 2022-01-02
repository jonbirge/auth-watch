function [ipsorted, nsorted] = ipcount(ips)

% compute unique
n = length(ips);
[ipu, ~, ic] = unique(ips);
nu = length(ipu);

% compute counts
ndata = zeros(1, nu);
for k = 1:n
  ndata(ic(k)) = ndata(ic(k)) + 1;
end

% sort
[~, ksort] = sort(ndata, 'descend');
ipsorted = ipu(ksort);
nsorted = ndata(ksort);
