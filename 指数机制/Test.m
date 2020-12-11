%independent confidence epsilo
function Test(N,T,epsilo_L,epsilo_R)
X=zeros(N,T); %opinion profile
X0=rand(N,1); %initial opinion profile
X(:,1)=X0;
u=0.5+randn(N,1)/6; %weight
        
for i=2:T
    for j=1:N
        sum1=0;
        sum2=0;
        cnt=0;
        for k=1:N
            dis=X(k,i-1)-X(j,i-1);
            if (dis<=epsilo_R) && (dis>=-epsilo_L)
                sum1=X(k,i-1)+sum1;
                cnt=cnt+1;
            else
                sum2=X(k,i-1)+sum2;
            end
        end
        X(j,i)=sum1/cnt;
    end
end
for k=1:N
    plot([1:T],X(k,:),'Color',[1-X0(k),X0(k),X0(k)]);
    hold on
end
end

