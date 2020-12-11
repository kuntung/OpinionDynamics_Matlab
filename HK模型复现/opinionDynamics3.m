%��������agent�Ĺ۵�,���Ҵ�reputation
function opinionDynamics3(N,T,epsilo)
X0=rand(N,1);%��ʼ�۵�Ϊ[0,1]֮������ֵ
% X0=0:1/(N-1):1; %uniform initial opinion profile
reputation=[1 2 3 5];
attributeLoad=ones(N,T);
X=zeros(N,T);
X(:,1)=X0;
for j=2:T
    W=eye(N);
    for i=1:N
        cnt=0;%����Чreputation
        c1=0;
        c2=0;
        c3=0;
        c4=0;%��ʼ����ͬreputation�ĸ�����
        dis=ones(1,N);
        attribute=zeros(1,N);%Ԥ��������reputation����
        for k=1:N
            dis(k)=abs(X(i,j-1)-X(k,j-1));
            if dis(k)<=epsilo/4
                c4=c4+1;
                attribute(k)=reputation(4);
            else
                if dis(k)<=epsilo/2
                    c3=c3+1;
                    attribute(k)=reputation(3);
                else
                    if dis(k)<=3*epsilo/4
                        c2=c2+1;
                        attribute(k)=reputation(2);
                    else
                        if dis(k)<=epsilo
                            c1=c1+1;
                            attribute(k)=reputation(1);
                        end
                    end
                end
            end
            %�õ���ǰ����ʱ���ڣ���ͬreputation��������
            cnt=c1*reputation(1)+c2*reputation(2)+c3*reputation(3)+c4*reputation(4);
        end
        %���ݸ�����reputationֵ�Ĳ�ͬ���費ͬ��Ȩ��
        W(i,attribute==reputation(1))=reputation(1)/cnt;
        W(i,attribute==reputation(2))=reputation(2)/cnt;
        W(i,attribute==reputation(3))=reputation(3)/cnt;
        W(i,attribute==reputation(4))=reputation(4)/cnt;        
    end
    X(:,j)=W*X(:,j-1);
end
for k=1:N
    plot(0:T-1,X(k,:));
    hold on;
end
delta=diff(X');
% subplot(2,1,2);

figure(2)
plot(0:1:T-2,delta);
end
