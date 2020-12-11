function BC_TTA(N,T,epsilo_L,epsilo_R,a,b)
%���µ����۵�
X=zeros(N,T); %opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
% X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%������Ϊ����
X(:,1)=X0;
% A(:,1)=(X0>=0.5);%��Ϊ��ʼ��,��������۵�
A(:,1)=TTA(X0,isNeighbor(X0,epsilo_L,epsilo_R),a,b);
% A(:,1)=randi([0,1],N,1);%��Ϊ��ʼ���������ʼ��
frequency_Action=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action(1,1)=sum(A(:,1)==1)/N;
for i=2:T
    %���й۵����
    oldNeighbor=isNeighbor(X(:,i-1),epsilo_L,epsilo_R);
    for j=1:N
        acc=0;
        cnt=0;
        for k=1:N%�����и���j����BCmodel�ж�
            if oldNeighbor(j,k)==1  
%                 temp_P=coda_rule(X(j,i-1),A(k,i-1),X(k,1:i-1),A(k,1:i-1));%���뵱ǰ����j����ʷ�۵����ʷ��Ϊ
                temp_P=coda_rule(X(j,i-1),A(k,i-1),X(k,1:i-1),A(k,1:i-1),a,b);%���뵱ǰ����j����ʷ�۵����ʷ��Ϊ
                acc=temp_P+acc;
                cnt=cnt+1;
            end
        end
        if sum(oldNeighbor(j,:))==0
            X(j,i)=X(j,i-1);
        else
            X(j,i)=acc/cnt;
        end
    end
    %���ݸ��º�õ��Ĺ۵�����ھӼ��ж�
    newNeighbor=isNeighbor(X(:,i),epsilo_L,epsilo_R);
    A(:,i)=TTA(X(:,i),newNeighbor,a,b);%������ֵ������Ϊ���ƣ��Ե�ǰ�۵������Ϊѡ��
    frequency_Action(1,i)=sum(A(:,i)==1)/N;%���㵱ǰAction=1����
end

%shading interp
%���ƹ۵����ͼ
figure(1)
subplot(2,1,1)
for i=1:N
    plot(0:T-1,X(i,:),'Color',[X0(i),abs(0.7-X0(i)),abs(0.4-X0(i))]);
    hold on;
end
title({'CODA&TTA';
    ['a:' num2str(a) ' b:' num2str(b) ];
    ['epsilon_L:' num2str(epsilo_L) 'epsilon_R:' num2str(epsilo_R)]})
subplot(2,1,2)
plot(0:T-1,frequency_Action,0:T-1,1-frequency_Action);
ylim([0 1]);
legend('Action=1','Action=0')
title({['a:' num2str(a) ' b:' num2str(b) ];
    ['epsilon_L:' num2str(epsilo_L) 'epsilo_R:' num2str(epsilo_R)]})
%������Ϊ����ͼ
%plot3����
figure(2)
bar3(A)
xlim([0 T+1]);
ylim([0 N+1]);
title({['a:' num2str(a) ' b:' num2str(b) ];
    ['epsilon_L:' num2str(epsilo_L) 'epsilon_R:' num2str(epsilo_R)]})

end
