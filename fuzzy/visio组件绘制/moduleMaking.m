fis=newfis('tempFIS')
fis=addvar(fis,'input','Comment',[0 10])
% fis=addfis(fis,'input',1,'gaussmf',[3 5])
% fis=addmf(fis,'input',1,'gaussmf',[1 5])
fis=addmf(fis,'input',1,'','gaussmf',[5 5])
plotmf(fis,'input',1)
axis off;
