%随机考虑一个观点，指数机制,带confidence level
function opinionDynamics2(N,T,epsilo)
X0=rand(N,1);%初始观点为[0,1]之间的随机值
% X0=0:1/(N-1):1; %uniform initial opinion profile
X=zeros(N,T);
X(:,1)=X0;
for j=2:T
    W=eye(N);
    for i=1:N
        while 1
            neighbor=randi(N);
            if neighbor~=i
                break;
            end
        end
        dis=abs(X(i,j-1)-X(neighbor,j-1));
        if dis<=epsilo
            W(i,neighbor)=exp(-dis);
            W(i,i)=1-exp(-dis);
        end
    end
    X(:,j)=W*X(:,j-1);
end
X=round(X,3);
if X(:,T-1)==X(:,T)
    disp('consensus')
end
%根据初始观点上色
for t=1:N
    plot(0:T-1,X(t,:),'Color',[X0(t),abs(0.7-X0(t)),abs(0.4-X0(t))]);
    hold on;
end
end
