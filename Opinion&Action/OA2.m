%�ڷǶԳ���������������£������û���Ϊ��۵�Ķ�̬�仯
%���г�ʼ�۵��������
%�۵���¹����ǷǶԳƵ����Ŷ�
%��ʼ��Ϊ�����������
%�û���Ϊ�����ݹ۵�ֵ�仯
%����2����Ϊ����hj��ͬ
function OA2(N,T,epsilo_L,epsilo_R)
H=randi([1,3],N,1);
H(H==1)=0.3;
H(H==2)=0.5;
H(H==3)=0.7;
X=zeros(N,T); %opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
% X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%������Ϊ����
X(:,1)=X0;
for t=1:N
    if X(t,1)>=H(t)
        A(t,1)=1;
    end
end
frequency_Action=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action(1,1)=sum(A(:,1))/N;
for i=2:T
    for j=1:N
        acc=0; 
        cnt=0;
        for k=1:N
            dis=X(k,i-1)-X(j,i-1);
            if (dis<=epsilo_R) && (dis>=-epsilo_L)
                acc=X(k,i-1)+acc;
                cnt=cnt+1;
            end
        end
        X(j,i)=acc/cnt;
    end
    for t=1:N
        if X(t,i)>=H(t)
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
    hold on 
end
title({'����2���۵���Ӧͼ';
    ['agent��:' num2str(N) ' ��������:' num2str(T) ' ������:' num2str(epsilo_L) ' ������:' num2str(epsilo_R)]})
subplot(2,1,2)
plot(0:T-1,frequency_Action,0:T-1,1-frequency_Action);
ylim([0 1]);
legend('Action=1','Action=0')
title({['agent��:' num2str(N) ' ��������:' num2str(T)];
    ['������:' num2str(epsilo_L) ' ������:' num2str(epsilo_R)];
    ['��Ϊ��Ӧֵ: 0.3 0.5 0.7']})
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
    ['��Ϊ��Ӧֵ: 0.3 0.5 0.7']})


end

