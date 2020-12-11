%对于目标agent实现CODA观点更新机制
%实现的是Martin论文中的(2)
%拓展为三种情况:Action=1,Action=-1,no-action
function [Pinew] = coda_rule( Pi,Aj,Xi_history,Ai_history,a,b)
% Dynamic CODA Rule
%计算邻居历史偏好Acton=1时的选择率
b=0.5;
a=0.5;
%考虑观点值为0.5的情况
pre1=sum(Xi_history>b);
pre0=sum(Xi_history<a);
if pre1>0
    A1P1=sum(Ai_history(Xi_history>b)==1)/pre1;%alpha
    A0P1=sum(Ai_history(Xi_history>b)==0)/pre1;%1-alpha
else
    A1P1=0;
    A0P1=0;
end
%计算邻居历史偏好Acton=0时的选择
if pre0>0
    A0P0=sum(Ai_history(Xi_history<a)==0)/pre0;%belta
    A1P0=sum(Ai_history(Xi_history<a)==1)/pre0;%1-belta
else
    A0P0=0;
    A1P0=0;
end
Flag=-1;
%当邻居行为为Action=1时所用表达式标识符
if Aj==1
    if Pi==0
        Flag=0;
    else
        if Pi==1
            Flag=1;     
        else
            Flag=2;
        end
    end
    if A1P0==0
        Flag=1;
    end
    if A1P1==0
        Flag=0;
    end
else%当邻居行为为Action=0时所用表达式标识符
    %O2=Pb/(1-Pb)*A0P0/A0P1
   if Pi==1
        Flag=1;
    else
        if Pi==0
            Flag=0;     
        else
            Flag=3;
        end
    end
    if A0P0==0
        Flag=1;
    end
    if A0P1==0
        Flag=0;
    end
end
if Aj==0
    Flag=4;
end
%更新得到当前时刻个体i的观点值
switch Flag
    case 0
        Pinew=0;
    case 1
        Pinew=1;
    case 2
        O1=A1P1/A1P0*Pi/(1-Pi);
        Pinew=O1/(1+O1);
    case 3
        O2=A0P1/A0P0*Pi/(1-Pi);
        Pinew=O2/(1+O2);
    case 4
        Pinew=Pi;
    otherwise
        disp('The opinion domain is wrong');
end
end
