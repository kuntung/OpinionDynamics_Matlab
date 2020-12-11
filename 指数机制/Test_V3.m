function Test_V3(N,T,epsilo)
X=zeros(N,T);
X0=rand(N,1);
X(:,1)=X0;
for i=2:T
    for j=1:N
        sum=0;  %???????¨®????????
        cnt=0;  %????????
        w=ones(N,1);
        dis=ones(N,1);
        W=speye(N);
        for k=1:N
            dis(k)=X(k,i-1)-X(j,i-1);
            if abs(dis(k))<=epsilo
                sum=sum+dis(k);
                cnt=cnt+1;
            end
        end
        for k=1:N
            if abs(dis(k))<=epsilo
                w(k)=exp(abs(dis(k))/sum)/cnt;
            else
                w(k)=0;
            end
            W=spdiags(w,0,N,N);
            W(j,:)=W(j,:)+W(k,:);
            W(j,j)=2-trace(W);
        end
        X(:,i)=W(j,:)*X(:,i-1);
    end
%»æÍ¼²¿·Ö
for k=1:N
    plot(1:T,X(k,:),'Color',[1-X0(k),X0(k),X0(k)]);
    hold on
end
end