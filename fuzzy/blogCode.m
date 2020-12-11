clear
human=newfis('heightEst');
human=addvar(human,'input','Height',[10 200]);
human=addmf(human,'input',1,'High','smf',[120 170]);
human=addmf(human,'input',1,'low','zmf',[80 150]);
plotmf(human,'input',1)
