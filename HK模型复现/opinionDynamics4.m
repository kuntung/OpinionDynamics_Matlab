%考虑所有agent的观点,指数机制加confidence level
function opinionDynamics4(N,T,epsilo)
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
            if dis(k)<=epsilo %testModel权重机制2
                cnt=cnt+1;
            end
        end
%         W(i,:)=exp(-dis)/cnt; %更新权重机制1
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
end
