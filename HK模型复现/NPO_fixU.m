function NPO_fixU(N,T,epsilo)
X=zeros(N,T); %opinion profile
% X0=rand(N,1); %rand initial opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
X(:,1)=X0;

for i=2:T
%     u=0.5+randn(N,1)/6; %weight
%     u(u<0)=0;
%     u(u>1)=1;
    u=0.5;
    for j=1:N
        neighbor=randi(N);
        if abs(X(j,i-1)-X(neighbor,i-1))<=epsilo
            X(j,i)=X(j,i-1)+u*(X(neighbor,i-1)-X(j,i-1));
        else
            X(j,i)=X(j,i-1);
        end
    end
end
for k=1:N
    plot(0:T-1,X(k,:),'-x','Color',[X0(k),abs(0.7-X0(k)),abs(0.4-X0(k))]);
    hold on
end
end

