function NPO_vard(N,T)
X=zeros(N,T); %opinion profile
% X0=rand(N,1); %rand initial opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
X(:,1)=X0;

for i=2:T
%     u=0.5+randn(N,1)/6; %weight
%     u(u<0)=0;
%     u(u>1)=1;
    u=0.5;
    epsilo(1:N)=0.2;
    for k=1:8
        temp=randi(N);
        epsilo(temp)=0.4;
    end
    for j=1:N
        neighbor=randi(N);
        if abs(X(j,i-1)-X(neighbor,i-1))<=epsilo(j )
            X(j,i)=X(j,i-1)+u*(X(neighbor,i-1)-X(j,i-1));
            X(neighbor,i)=X(neighbor,i-1)+u*(X(j,i-1)-X(neighbor,i-1));
            if epsilo(j)~=epsilo(neighbor)
                epsilo(j)=0.4;
            end
        else
            X(j,i)=X(j,i-1);
        end
       
    end
end
for k=1:N
    if epsilo(k)==0.2
        plot(0:T-1,X(k,:),'r');
        hold on
    else
        plot(0:T-1,X(k,:),'b');
        hold on
    end
end
disp(sum(epsilo==0.4));
end

