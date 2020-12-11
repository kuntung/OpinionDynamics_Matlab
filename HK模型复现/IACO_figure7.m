d0=0.5;
alpha=0.7;%初始参数
T=20;%迭代时间
X0=zeros(101,1);%初始opinion X0
N=size(X0,1);
% X0=rand(N,1);
for i=1:101
    horizon(i)=(i-1)/100;
end
X0=horizon;
X=zeros(N,T);
X(:,1)=X0;
cnt=0;
num=0;
for j=2:T
    for i=1:N
        X(i,j)=alpha*X(i,j-1)+(1-alpha)*mean(X(abs(X(:,j-1)-X(i,j-1))<=d0,j-1));
    end
    cnt=sum(abs(X(:,j-1)-X(i,j-1))<=d0);
    d0=d0*alpha.^(-cnt/2);
end
figure(1)
for i=1:T
    plot(horizon,round(X(:,i),2),'-*');
    hold on;
end
figure(2)
plot(X')

        
