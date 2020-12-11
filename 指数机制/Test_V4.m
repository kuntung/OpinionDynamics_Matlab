function [Dis,Wei]=Test_V4(N,T,epsilo)
X=zeros(N,T);
X0=rand(N,1);
X(:,1)=X0;
temp1=zeros(N,T-1);
temp2=ones(N,T-1);

for i=2:T
    for j=1:N
        sum=0;  %符合要求的观点和
        cnt=0;  %统计个数
        w=zeros(N,1);
        dis=ones(N,1);
        W=speye(N);
        %判断是否符合epsilo要求
        for k=1:N
            dis(k)=X(k,i-1)-X(j,i-1);
            if abs(dis(k))<=epsilo
                sum=sum+abs(dis(k));
                cnt=cnt+1;
            end
        end
        temp2(:,i-1)=dis;
        %权重更新部分
        for k=1:N
            if abs(dis(k))<=epsilo
                w(k)=exp(abs(dis(k))/sum)/cnt;
            else
                w(k)=0;
            end
            temp1(:,i-1)=w;
            W=spdiags(w,0,N,N);
            W(j,:)=W(j,:)+W(k,:);
            W(j,j)=2-trace(W);
        end
    X(:,i)=W(j,:)*X(:,i-1);
    end
%绘图部分
    for k=1:N
        plot(1:T,X(k,:),'Color',[1-X0(k),X0(k),X0(k)]);
        hold on
    end

end
Dis=temp2;
Wei=temp2;
end

        
                
