clear
N=20;
P1=0.5;
P2=0.7;
Aj=randi([0,1],N,1);
Xj=0:1/(N-1):1; %uniform initial opinion profile
% Xj=rand(N,1); %uniform initial opinion profile
% len=length(Aj);
% %计算邻居历史偏好Acton=1时的选择
% A1P1=sum(Aj(Xj>0.5)==1)/sum(Xj>0.5);
% A0P1=sum(Aj(Xj>0.5)==0)/sum(Xj>0.5);
% %计算邻居历史偏好Acton=0时的选择
% A0P0=sum(Aj(Xj<0.5)==0)/sum(Xj<0.5);
% A1P0=sum(Aj(Xj<0.5)==1)/sum(Xj<0.5);
% O1=A1P1/A1P0*P1/(1-P1);
% Pinew1=O1/(1+O1);
% O2=A0P0/A0P1*P2/(1-P2);
% Pinew2=O2/(1+O2);
P=daco_rule(P1,Xj,Aj)