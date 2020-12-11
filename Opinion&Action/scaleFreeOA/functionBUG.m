%用于测试function的实现情况
N=9;
a=0.3;
b=0.7;
% X0=rand(1,N);
X0=[0 0 0 0 0.5 1 1 1 1]
[noUse, neighborM]=FreeScale(N);
neighborM(5,:)=[1 1 1 1 1 1 1 1 1];
Action=zeros(1,N);
Action(X0>b)=1
Action(X0<a)=-1
Action=obNeighborA(X0,neighborM,Action)