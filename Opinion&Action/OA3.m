%�ڶԳơ��ǶԳ���������������£������û���Ϊ��۵�Ķ�̬�仯
%���г�ʼ�۵��������
%�۵���¹����ǷǶԳƵ����Ŷ�
%��ʼ��Ϊ�����������
%����3���ھ�
function OA3(N,T,epsilo_L,epsilo_R)
%������Ϊ������ֵ
H=randi([1,3],N,1);
H(H==1)=0.7;
H(H==2)=0.7;
H(H==3)=0.7;
X=zeros(N,T); %opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
% X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%������Ϊ����
X(:,1)=X0;
%��ʼ��Ϊ�����ʼ��
% A(:,1)=randi([0,1],N,1);
A(:,1)=init_Action(X0,0.3,0.7);
frequency_Action=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action(1,1)=sum(A(:,1))/N;
same_value=zeros(N,T);%��ʼ��ÿ��agentÿ���������ڵ��ھ�ACTION�۲�ֵ
for i=2:T
    for j=1:N
        acc=0; 
        cnt=0;
        act_same=0;
        temp_P=zeros(N,1);
        for k=1:N
            dis=X(k,i-1)-X(j,i-1);
            %�ڽ���ȷ��
            if (dis<=epsilo_R) && (dis>=-epsilo_L)
                temp_P(k)=coda_rule()
                acc=X(k,i-1)+acc;
                cnt=cnt+1;
                %�ж�agent��ƫ������Action
                %ƫ����Action=1
                if X(j,i-1)>=0.5
                    %�ж��ھӵ�Action
                                                                                                                                                              if A(k,i-1)==1
                        act_same=act_same+1;
                    end
                end
                %ƫ����Action=0
                if X(j,i-1)<0.5
                    %�ж��ھӵ�Action
%                     if A(k,i-1)==0&&X(k,i-1)<=0.5
                    if A(k,i-1)==0
                        act_same=act_same+1;
                    end
                end
            end
        end
        X(j,i)=acc/cnt;
        same_value(j,i)=act_same/cnt;%���㵱ǰ�������ڣ�agent���ھӹ۲���
    end
    %�Ե�ǰ�������ڵ�ÿ��agent����Action�ж�
    for t=1:N
        %���ڹ۵�ƫ����Action=1��agent
        if X(t,i)>=0.5&&same_value(t,i)>=H(t)
            A(t,i)=1;
        else
            A(t,i)=0;
        end
        %���ڹ۵�ƫ����Action=0��agent
        if X(t,i)<0.5&&same_value(t,i)>=H(t)
            A(t,i)=0;
        else
            A(t,i)=1;
        end
    end
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
    ['��Ӧ����: ' num2str(H(1))]})
%������Ϊ����ͼ
figure(2)
% subplot(2,1,1)
% for i=1:N
%     plot(0:T-1,A(i,:),'-o');
%     hold on 
% end
% title('����2��Action�仯����')


%plot3����
bar3(A)
xlim([0 T+1]);
ylim([0 N+1]);
title({['agent��:' num2str(N) ' ��������:' num2str(T)];
    ['������:' num2str(epsilo_L) ' ������:' num2str(epsilo_R)];
    ['��Ӧ����: ' num2str(H(1))]})
end

