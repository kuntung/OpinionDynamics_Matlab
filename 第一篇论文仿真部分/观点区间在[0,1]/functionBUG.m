%���ڲ����ܷ�ʵ�ֶ��ڹ۵�ֵ������[a,b]�ĸ��壬��Ϊѡ�����
a=0.3;
b=0.7;
epsilo_L=0.3;
epsilo_R=0.3;
A(:,1)=X0unif;
T=1000;
frequency_ActionN1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
for i=2:T
freeMatrix=FreeScale(N);
neighborM0=isOPM(X0,freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
A(:,i)=obNeighborA(X0,neighborM0,a,b);
frequency_Action1(1,i)=sum(A(:,i)==1)/N;
frequency_ActionN1(1,i)=sum(A(:,i)==-1)/N;
end
plot(0:T-1,frequency_Action1,0:T-1,frequency_ActionN1);