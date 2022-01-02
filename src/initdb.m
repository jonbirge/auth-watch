% Update DB
% Only script which may write to the database.

clear
pkg load parallel

params = getsettings();
savename = params.savename;
logname = params.logname;

%%

fprintf('merging newcount log...\n')
tic
[d, newcount] = parparselogfile(logname);
toc
fprintf('found %d records\n', newcount)

%%

fprintf('writing database...\n')
save(savename, '-6', 'd');
