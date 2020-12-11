%independent confidence epsilo
function Test_V2(N,T)
X=zeros(N,T); %opinion profile
X0=rand(N,1); %initial opinion profile
X(:,1)=X0;
u=0.5+randn(N,1)/6;
u(u<0|u>1)=0.5;        
for i=2:T
    for j=1:N
        sum=0;
        cnt=0;
        for k=1:N
            dis=X(k,i-1)-X(j,i-1);
            if abs(dis)<=u
                sum=X(k,i-1)+sum;
                cnt=cnt+1;
            end
        end
        X(j,i)=sum/cnt;
        u=u*N/cnt;
    end
end
for k=1:N
    plot([1:T],X(k,:),'Color',[1-X0(k),X0(k),X0(k)]);
    hold on
end
end

