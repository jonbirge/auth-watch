function k = linecount(filename)

fid = fopen(filename);
k = 0;
l = fgetl(fid);
while l ~= -1
  k = k + 1;
  l = fgetl(fid);
end
