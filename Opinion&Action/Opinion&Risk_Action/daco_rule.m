%对于目标agent实现CODA观点更新机制
function [Pinew] = daco_rule( Pi,Xj,Aj)
% Dynamic CODA Rule
%计算邻居历史偏好Acton=1时的选择率
pre1=sum(Aj==1);
pre0=sum(Aj==0);
if pre1>0
    P1A1=sum(Xj(Aj==1)>=0.5)/pre1;%alpha
    P0A1=sum(Xj(Aj==1)<0.5)/pre1;%alpha
else
    P1A1=0;
    P0A1=0;
end
%计算邻居历史偏好Acton=0时的选择
if pre0>0
    P1A0=sum(Xj(Aj==0)>=0.5)/pre0;%alpha
    P0A0=sum(Xj(Aj==0)<0.5)/pre0;%alpha
else
    P0A0=0;
    P1A0=0;
end
%判断传入的观点偏好
Flag=-1;
if Pi==0
    Flag=0;
else
    if Pi==1
        Flag=1;     
    else
        Flag=2;
    end
end
if P0A1==0&&pre1~=0
    Flag=3;
end
if pre1==0
    Flag=4;
end

switch Flag
    case 1
        Pinew=1;
    case 0
        Pinew=0;
    case 2
        O1=P1A1/P0A1*Pi/(1-Pi);
        Pinew=O1/(1+O1);
    case 3
        Pinew=1;
    case 4
        Pinew=0;
    otherwise
        disp('The opinion domain is wrong');
end

