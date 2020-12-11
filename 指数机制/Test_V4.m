function [Dis,Wei]=Test_V4(N,T,epsilo)
X=zeros(N,T);
X0=rand(N,1);
X(:,1)=X0;
temp1=zeros(N,T-1);
temp2=ones(N,T-1);

for i=2:T
    for j=1:N
        sum=0;  %����Ҫ��Ĺ۵��
        cnt=0;  %ͳ�Ƹ���
        w=zeros(N,1);
        dis=ones(N,1);
        W=speye(N);
        %�ж��Ƿ����epsiloҪ��
        for k=1:N
            dis(k)=X(k,i-1)-X(j,i-1);
            if abs(dis(k))<=epsilo
                sum=sum+abs(dis(k));
                cnt=cnt+1;
            end
        end
        temp2(:,i-1)=dis;
        %Ȩ�ظ��²���
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
%��ͼ����
    for k=1:N
        plot(1:T,X(k,:),'Color',[1-X0(k),X0(k),X0(k)]);
        hold on
    end

end
Dis=temp2;
Wei=temp2;
end

        
                
