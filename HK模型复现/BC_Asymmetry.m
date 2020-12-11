%independent confidence epsilo
function BC_Asymmetry(N,T,epsilo_L,epsilo_R)
X=zeros(N,T); %opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
% X0=rand(N,1); %random initial opinion profile
X(:,1)=X0;
% u=0.5+randn(N,1)/6; %weight        
for i=2:T
    for j=1:N
        sum=0;
        cnt=0;
        for k=1:N
            dis=X(k,i-1)-X(j,i-1);
            if (dis<=epsilo_R) && (dis>=-epsilo_L)
                sum=X(k,i-1)+sum;
                cnt=cnt+1;
            end
        end
        X(j,i)=sum/cnt;
    end
end
% for k=1:N
%     plot([0:T-1],X(k,:),'Color',[1-X0(k),X0(k),X0(k)]);
%     hold on
% end
figure(1)
for i=1:N
    plot(0:T-1,X(i,:),'Color',[X0(i),abs(0.7-X0(i)),abs(0.4-X0(i))]);
    hold on;
end
% plot(0:T-1,X');
%ªÊ÷∆figure 5
delta=diff(X');
% subplot(2,1,2);
% figure(2)
% plot(0:1:T-2,delta);

end

