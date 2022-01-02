function cc = whoisat(ipstr)
  
[~, out] = system(['whois ', ipstr, ' | grep [Cc]ountry']);
cc = sscanf(out, 'Country:%s');
if isempty(cc)
cc = sscanf(out, 'country:%s');
end
  
end
