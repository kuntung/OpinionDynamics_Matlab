%%%%%%%%%%考虑所有个体中，满足带bounded confidence level的指数迭代模型
N=200;T=10;
epsilo=0.3;
% X0=rand(N,1);%初始观点为[0,1]之间的随机值
X0=0:1/(N-1):1; %uniform initial opinion profile
X=zeros(N,T);
X(:,1)=X0;
for j=2:T
    W=eye(N);
    for i=1:N
        cnt=0;
        dis=ones(1,N);
        for k=1:N
            dis(k)=abs(X(i,j-1)-X(k,j-1));
            if dis(k)<=epsilo
                cnt=cnt+1;
            end
             if dis(k)<epsilo/100
                 dis(k)=0;
             else
                 if dis(k)>=epsilo
                     dis(k)=10e9;
                 end
             end
                 
        end
%          W(i,dis<epsilo)=1/cnt; %BCmodel,权重机制1
        for t=1:N
            if dis(t)<=epsilo
                W(i,t)=exp(-dis(t))/cnt;%testModel权重机制2
            else
                W(i,t)=0;
            end
        end
         W(i,i)=1+W(i,i)-sum(W(i,:));
    end
    X(:,j)=W*X(:,j-1);
end
for t=1:N
    plot(0:T-1,X(t,:),'Color',[X0(t),abs(0.7-X0(t)),abs(0.4-X0(t))]);
    hold on;
end