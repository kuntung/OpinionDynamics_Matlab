%��������agent�Ĺ۵�,ָ�����Ƽ�double confidence level
%aij=weight/sum(weight)
function opinionDynamics5(N,T,epsilomin,epsilomax)
X0=rand(N,1);%��ʼ�۵�Ϊ[0,1]֮������ֵ
% X0=0:1/(N-1):1; %uniform initial opinion profile
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
            if dis(k)<=epsilomin
                w(k)=1;
            else
                if dis(k)<=epsilomax 
                    w(k)=exp(-dis(k));
                end
            end
        end
        %����Ȩ�ؾ���ʵ��ֵ
        for t=1:N
            W(i,t)=w(t)/sum(w);
        end
    end
    X(:,j)=W*X(:,j-1);
end
for t=1:N
    plot(0:T-1,X(t,:),'Color',[X0(t),abs(0.7-X0(t)),abs(0.4-X0(t))]);
    hold on;
end
title('Random initial opinion profile-mechanism 2');

end
