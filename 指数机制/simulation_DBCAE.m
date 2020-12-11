%�����ʽΪsimulation_DBCAE(agent��������ʱ�䣬�ұ�������Сֵ���ұ��������ֵ������ϵ��K)
%��������agent�Ĺ۵�
%ָ�����Ƽ�double confidence level
%Asymmetric confidence level, epsilonL=k*epsilonR
%aij=1/cnt or 0 or 1-sum(aij)
function simulation_DBCAE(N,T,epsilonRmin,epsilonRmax,k)
% X0=rand(N,1);%��ʼ�۵�Ϊ[0,1]֮������ֵ
X0=0:1/(N-1):1; %uniform initial opinion profile
%�õ�epsilonLmin �Լ�epsilonLmax
epsilonLmin=epsilonRmin*k;
epsilonLmax=epsilonRmax*k;
X=zeros(N,T);
X(:,1)=X0;
for j=2:T
    W=eye(N);
    for i=1:N
        dis=ones(1,N);%��ʼ���۵��ֵ
        w=zeros(1,N);%��ʼ����Ȩ��ai��
        for k=1:N
            dis(k)=X(i,j-1)-X(k,j-1);
            if dis(k)>=-epsilonLmin && dis(k)<=epsilonRmin%�������۵�֮���ֵdif�õ���Ȩ�ط���
                w(k)=1;
            else
                if (dis(k)<=epsilonRmax && dis(k)>=epsilonRmin)|| (dis(k)>=-epsilonLmax &&dis(k)<=-epsilonLmin) 
                    w(k)=exp(-abs(dis(k)));
                end
            end%Ȩ�ط����������
        end
        %�õ���ǰ����Ȩ��������
        for t=1:N
            W(i,t)=w(t)/sum(w);
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
