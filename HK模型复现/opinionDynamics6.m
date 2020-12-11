%��������agent�Ĺ۵�,ָ�����Ƽ�double confidence level
%aij=1/cnt or 0 or 1-sum(aij)
function opinionDynamics6(N,T,epsilomin,epsilomax)
% X0=rand(N,1);%��ʼ�۵�Ϊ[0,1]֮������ֵ
X0=0:1/(N-1):1; %uniform initial opinion profile
X=zeros(N,T);
X(:,1)=X0;
for j=2:T
    W=eye(N);
    for i=1:N
        cnt=0;
        dis=ones(1,N);%��ʼ���۵��ֵ
        w=zeros(1,N);%��ʼ����Ȩ��ai��
        for k=1:N
            dis(k)=abs(X(i,j-1)-X(k,j-1));
            if dis(k)<=epsilomin%�������۵�֮���ֵdif�õ���Ȩ�ط���
                w(k)=1;
                cnt=cnt+1;
            else
                if dis(k)<=epsilomax 
                    cnt=cnt+1;
                    w(k)=exp(-dis(k));
                end
            end%Ȩ�ط����������
        end
        %�õ���ǰ����Ȩ��������
        for t=1:N
            W(i,t)=w(t)/cnt;
        end
        W(i,i)=1+W(i,i)-sum(W(i,:));
    end
    X(:,j)=W*X(:,j-1);
end
for t=1:N
    plot(0:T-1,X(t,:),'Color',[X0(t),abs(0.7-X0(t)),abs(0.4-X0(t))]);
    hold on;
end
title('Uniform initial opinion profile-mechanism 1');
end
