%对于目标agent实现CODA观点更新机制
%实现的是Martin论文中的(2)，即alpha和belta为固定的值
function [Pinew] = coda_rule_const( Pi,Action,alpha,belta)
% Dynamic CODA Rule
Flag=-1;
if Action==1
    Flag=1;
else
    if Action==-1
        Flag=2;
    end
end
if Pi==1 && Flag==1
    Flag=3;%无法增加的情形
elseif Pi==0&&Flag==2
    Flag=4;%无法减小的情形
end

switch Flag
    case 1
        O1=Pi/(1-Pi)*alpha/(1-belta);
        Pinew=O1/(1+O1);
    case 2
        O2=Pi/(1-Pi)*(1-alpha)/belta;
        Pinew=O2/(1+O2);
    case 3
        Pinew=1;
    case 4
        Pinew=0;
end
            
end
