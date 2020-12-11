%�ڶԳơ��ǶԳ���������������£������û���Ϊ��۵�Ķ�̬�仯
%���г�ʼ�۵���ȸ���
%�۵���¹����ǷǶԳƵ����Ŷ�
%��ʼ��Ϊ���÷��������
%H-Kģ���µķ����;���&CODA�۵����
function ORA(N,T,epsilo_L,epsilo_R)
%���ɾ��߷��ձ�
%----����ʾ��1------
%ACTION=1 0     1
%ACTION=0 1     0
%�ϱ��ʾ������agent��ƫ��Pi
% lamda=[0 1;1 0];
lamda=[3 4;7 2]; 

% lamda=[-2 4;6 -4];
% lamda=[2 5;6 3];%һ���Ĺ۵�һ���ԡ�������Ϊ������ͬ
% lamda=[6 7;8 3];%����Լ��3�����ǹ۵㼰��Ϊ��������

% %----����ʾ��2------
% %ACTION=1 3     1
% %ACTION=0 2     5
% lamda=[3 2;1 5]; 

% lamda=[0 6;5 1]; 


X=zeros(N,T); %opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
% X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%������Ϊ����
X(:,1)=X0;
% A(:,1)=init_Act(X0,0.3,0.7); %�ֶγ�ʼ��Action
A(:,1)=riskyAction(X0',lamda);%�����;��߳�ʼ��
frequency_Action=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action(1,1)=sum(A(:,1))/N;
% same_value=zeros(N,T);%��ʼ��ÿ��agentÿ���������ڵ��ھ�ACTION�۲�ֵ
for i=2:T
    for j=1:N
        acc=0; 
        cnt=0;
        for k=1:N
            dis=X(k,i-1)-X(j,i-1);
            %�ڽ���ȷ��
            if (dis<=epsilo_R) && (dis>=-epsilo_L)
                if k~=j
%                     temp_P=daco_rule(X(j,i-1),X(k,1:i-1),A(k,1:i-1));
                    temp_P=coda_rule(X(j,i-1),X(j,1:i-1),A(j,1:i-1));
                    acc=temp_P+acc;
                    cnt=cnt+1;
                end
            end
        end
        X(j,i)=acc/cnt;
    end
    A(:,i)=riskyAction(X(:,i),lamda);
    frequency_Action(1,i)=sum(A(:,i))/N;
end
%���ƹ۵����ͼ
figure(1)
subplot(2,1,1)
for i=1:N
    plot(0:T-1,X(i,:),'Color',[X0(i),abs(0.7-X0(i)),abs(0.4-X0(i))]);
    hold on;
end
title({'CODA&���վ���';
    ['agent��:' num2str(N) ' ��������:' num2str(T) ];
    ['������:' num2str(epsilo_L) '������:' num2str(epsilo_R)]})
subplot(2,1,2)
plot(0:T-1,frequency_Action,0:T-1,1-frequency_Action);
ylim([0 1]);
legend('Action=1','Action=0')
title({['agent��:' num2str(N) ' ��������:' num2str(T)];
    ['������:' num2str(epsilo_L) ' ������:' num2str(epsilo_R)];
    ['���ձ�: [' num2str(lamda(1)) ' ' num2str(lamda(3)) ';' num2str(lamda(2))  ' ' num2str(lamda(4)) ']']})
%������Ϊ����ͼ
figure(2)
%plot3����
bar3(A)
xlim([0 T+1]);
ylim([0 N+1]);
title({['agent��:' num2str(N) ' ��������:' num2str(T)];
    ['������:' num2str(epsilo_L) ' ������:' num2str(epsilo_R)];
    ['���ձ�: [' num2str(lamda(1)) ' ' num2str(lamda(3)) ';' num2str(lamda(2))  ' ' num2str(lamda(4)) ']']})
end