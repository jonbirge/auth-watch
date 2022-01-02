function matlog(varargin)

dstr = datestr(now());
fprintf([dstr, ': ', varargin{1}, '\n'], varargin{2:end})

end
