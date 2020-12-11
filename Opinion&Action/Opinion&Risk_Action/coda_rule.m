%对于目标agent实现CODA观点更新机制
%实现的是Martin论文中的(2)
function [Pinew] = coda_rule( Pi,Xj,Aj)
% Dynamic CODA Rule
%计算邻居历史偏好Acton=1时的选择率
pre1=sum(Xj>=0.5);
pre0=sum(Xj<0.5);
if pre1>0
    A1P1=sum(Aj(Xj>=0.5)==1)/pre1;%alpha
    A0P1=sum(Aj(Xj>=0.5)==0)/pre1;%alpha
else
    A1P1=0;
    A0P1=0;
end
%计算邻居历史偏好Acton=0时的选择
if pre0>0
    A0P0=sum(Aj(Xj<0.5)==0)/pre0;%alpha
    A1P0=sum(Aj(Xj<0.5)==1)/pre0;%alpha
else
    A0P0=0;
    A1P0=0;
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
if A1P1==1||pre0==0||A1P0==0
    Flag=3;
end
if pre1==0||A1P1==0
    Flag=4;
end

switch Flag
    case 1
        Pinew=1;
    case 0
        Pinew=0;
    case 2
        O1=A1P1/A1P0*Pi/(1-Pi);
%         O1=A1P1/A1P0;
        Pinew=O1/(1+O1);
    case 3
        Pinew=1;
    case 4
        Pinew=0;
    otherwise
        disp('The opinion domain is wrong');
end

