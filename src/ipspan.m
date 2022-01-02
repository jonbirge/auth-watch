function T = ipspan(ips, d)

t = d.date;
n = length(ips);

T = zeros(1, n);
for k = 1:n
  m = strcmp(ips(k), d.ip);
  kms = find(m);
  kmin = min(kms);
  kmax = max(kms);
  T(k) = t(kmax) - t(kmin);
end
