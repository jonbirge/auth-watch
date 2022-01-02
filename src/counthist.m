function [b, c] = counthist(cnt, maxcnt)
  bs = 0:maxcnt;
  cnt(cnt > maxcnt) = maxcnt;
  [c, b] = hist(cnt, bs);
end
