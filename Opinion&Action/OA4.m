%�ڶԳơ��ǶԳ���������������£������û���Ϊ��۵�Ķ�̬�仯
%���г�ʼ�۵��������
%�۵���¹����ǷǶԳƵ����Ŷ�
%��ʼ��Ϊ�����������
%����4�������;���
function OA4(N,T,epsilo_L,epsilo_R)
%���ɾ��߷��ձ�
%---------------
%ACTION=1 5     3
%ACTION=0 4     6
lamda=[-2 5;4 1];
%������Ϊ������ֵ
% H=randi([1,3],N,1);
% H(H==1)=0.3;
% H(H==2)=0.3;
% H(H==3)=0.3;
X=zeros(N,T); %opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
% X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%������Ϊ����
X(:,1)=X0;
A(:,1)=randi([0,1],N,1);
frequency_Action=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action(1,1)=sum(A(:,1))/N;
% same_value=zeros(N,T);%��ʼ��ÿ��agentÿ���������ڵ��ھ�ACTION�۲�ֵ
for i=2:T
    A_temp=zeros(N,1);
    for j=1:N
        acc=0; 
        cnt=0;
        for k=1:N
            dis=X(k,i-1)-X(j,i-1);
            %�ڽ���ȷ��
            if (dis<=epsilo_R) && (dis>=-epsilo_L)
                acc=X(k,i-1)+acc;
                cnt=cnt+1;
            end
        end
        X(j,i)=acc/cnt;
%         same_value(j,i)=act_same/cnt;%���㵱ǰ�������ڣ�agent���ھӹ۲���
    end
    %�������
    Temp=[X(:,i) 1-X(:,i)];
    R=Temp*lamda';
    disp(R)
    for k=1:N
        ind=find(R(k,:)==min(R(k,:)))-1;
        A_temp(k,1)=ind(1);
    end
    A(:,i)=A_temp;
    frequency_Action(1,i)=sum(A(:,i))/N;
end
%���ƹ۵����ͼ
figure(1)
subplot(2,1,1)
for i=1:N
    plot(0:T-1,X(i,:),'Color',[X0(i),abs(0.7-X0(i)),abs(0.4-X0(i))]);
    hold on;
end
title({'����3���۵���Ӧͼ';
    ['agent��:' num2str(N) ' ��������:' num2str(T) ' ������:' num2str(epsilo_L) ' ������:' num2str(epsilo_R)]})
subplot(2,1,2)
plot(0:T-1,frequency_Action,0:T-1,1-frequency_Action);
ylim([0 1]);
legend('Action=1','Action=0')
title({['agent��:' num2str(N) ' ��������:' num2str(T)];
    ['������:' num2str(epsilo_L) ' ������:' num2str(epsilo_R)];
    ['���ձ�: [-2 5;4 1]']})
%������Ϊ����ͼ
figure(2)
%plot3����
bar3(A)
xlim([0 T+1]);
ylim([0 N+1]);
title({['agent��:' num2str(N) ' ��������:' num2str(T)];
    ['������:' num2str(epsilo_L) ' ������:' num2str(epsilo_R)];
    ['���ձ�: [-2 5;4 1]']})
end

