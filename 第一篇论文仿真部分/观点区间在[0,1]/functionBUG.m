%用于测试能否实现对于观点值在区间[a,b]的个体，行为选择从众
a=0.3;
b=0.7;
epsilo_L=0.3;
epsilo_R=0.3;
A(:,1)=X0unif;
T=1000;
frequency_ActionN1=zeros(1,T);%初始化频率为0
frequency_Action1=zeros(1,T);%初始化频率为0
for i=2:T
freeMatrix=FreeScale(N);
neighborM0=isOPM(X0,freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
A(:,i)=obNeighborA(X0,neighborM0,a,b);
frequency_Action1(1,i)=sum(A(:,i)==1)/N;
frequency_ActionN1(1,i)=sum(A(:,i)==-1)/N;
end
plot(0:T-1,frequency_Action1,0:T-1,frequency_ActionN1);