%independent confidence epsilo
function Temp=FO(N,T,epsilo_L,epsilo_R,X_initial,order)
if nargin<6
    order=0.1
end

X=zeros(N,T); %opinion profile
% X0=[0.1,0.3,0.45,0.7];
X0=X_initial; %initial opinion profile
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
        if order==1
            X(j,i)=sum/cnt
        else
            dy=glffdiff(sum,k,order);
            X(j,i)=dy/cnt;
        end
    end
    
end

X2=Uniform(X);
Temp=X2;
for k=1:N
    figure(1)
    subplot(2,1,1);
    plot([0:T-1],X(k,:),'Color',[1-X0(k),X0(k),X0(k)]);
    hold on
    subplot(2,1,2);
    plot([0:T-1],X2(k,:),'Color',[1-X0(k),X0(k),X0(k)]);
    hold on;

%     Y=mapminmax(X(k,:),0,1);
%     plot([1:T],Y,'Color',[1-X0(k),X0(k),X0(k)]);
%       hold on
%     Y=X(k,:)*diag(1./X(N:end));
%     plot([1:T],Y,'Color',[1-X0(k),X0(k),X0(k)]);
%     hold on
end
end

