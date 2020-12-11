%�����ʽΪWeightChange_HK(agent��������ʱ�䣬����뾶,Ȩ�طֶε�,Ȩ��a,Ȩ��b)
%��������agent�Ĺ۵�
%aij=1/cnt or 0 or 1-sum(aij)
%�ֶε�ȡ[0,1]֮��С��
%��(r)=a��[0,��/k]+b��[��/k,��]
function test=WeightChange_HK(N,T,epsilon,k,a,b)
% X0=rand(N,1);%��ʼ�۵�Ϊ[0,1]֮������ֵ
X0=0:1/(N-1):1; %uniform initial opinion profile
%�õ�epsilonLmin �Լ�epsilonLmax
epsilonmin=epsilon*k;
epsilonmax=epsilon;
X=zeros(N,T);
X(:,1)=X0;
for j=2:T
    W=eye(N);
    for i=1:N
        dis=ones(1,N);%��ʼ���۵��ֵ
        w=zeros(1,N);%��ʼ����Ȩ��ai��
        for k=1:N
            dis(k)=abs(X(i,j-1)-X(k,j-1));
            if dis(k)>=0 && dis(k)<=epsilonmin
                w(k)=a;
            else
                if dis(k)<=epsilonmax && dis(k)>=epsilonRmin
                    w(k)=b;
                end
            end%Ȩ�ط����������
        end
        %�õ���ǰ����Ȩ��������
        for t=1:N
            W(i,t)=w(t)/sum(w);
        end
    end
    X(:,j)=W*X(:,j-1);
end
test=W;
for t=1:N
    plot(0:T-1,X(t,:),'Color',[X0(t),abs(0.7-X0(t)),abs(0.4-X0(t))]);
    hold on;
end
title('Uniform initial opinion profile-mechanism 1');
end
