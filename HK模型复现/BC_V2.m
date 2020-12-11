%dependent confidence epsilo
function BC_V2(N,T,epsilo,m)
if nargin<4
    m=0;
    if nargin<3
        epsilo=0.6;
    end
    if nargin<2
        error('The number of opinions and Time input dont receive');
    end
end
X=zeros(N,T); %opinion profile
X0=rand(N,1); %initial opinion profile
X(:,1)=X0;
u=0.5+randn(N,1)/6; %weight
for i=2:T
    for j=1:N
        neighbor=randi(N);
        scalar=X(j,i-1)*m+(1-m)/2; %f(x)=mx+(1-m)/2
        epsilo_R=epsilo*scalar; 
        epsilo_L=epsilo*(1-scalar);%epsilo left and epsilo right
        if (X(j,i-1)-X(neighbor,i-1)<=epsilo_R) && (X(j,i-1)-X(neighbor,i-1)>=-epsilo_L)
            X(j,i)=X(j,i-1)+u(j)*(X(neighbor,i-1)-X(j,i-1));
        else
            X(j,i)=X(j,i-1);
        end
    end
end
for k=1:N
    plot([1:1:T],X(k,:),'Color',[1-X0(k),abs((1-u(k)))*X0(k),abs(0.5*u(k))*X0(k)]);
    hold on
end
end

