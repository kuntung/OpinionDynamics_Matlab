%�趨Ϊ�ޱ�������£��۵���ڽ�����ʼ�տɼ�����Ϊ���������й۵����ڸ���ɼ�
%�������Ϊ������Ŀ������ʱ�䣬�������䣬��Ϊ������ֵa,b,�Լ�CODA�۵���¹����alpha,belta
%�۵㡢��Ϊȷ���󲻻ᷢ���ı�
function scaleFree_UOA(N,T,epsilo_L,epsilo_R,a,b,alpha,belta)
%ʹ��ʦ�������ɵ��ڽӾ���B
% load B.mat;
% freeMatrix=B;
% N=200;
%ʹ���Լ����ɵ��ޱ�������ڽӾ���
[~, freeMatrix]=FreeScale(N);
X=zeros(N,T); %opinion profile
% X0=0:1/(N-1):1; %uniform initial opinion profile
X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%������Ϊ����0��ʾNo-Action,1��ʾAction=1��-1��ʾAction=-1
% freeMatrix=FreeScale(N);%���ɸ�����ĿΪN���ޱ�������ڽӾ���
X(:,1)=X0;
A(X(:,1)>b,1)=1;
A(X(:,1)<a,1)=-1;

% A(:,1)=randi([0,1],N,1);%��Ϊ��ʼ���������ʼ��
frequency_Action1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action1(1,1)=sum(A(:,1)==1)/N;
frequency_ActionN1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_ActionN1(1,1)=sum(A(:,1)==-1)/N;
frequency_Action0=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action0(1,1)=sum(A(:,1)==0)/N;


for i=2:T
    %���й۵����
    opinion_similarMi=isOPM(X(:,i-1),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
    for j=1:N
        if A(j,i-1)==0%������Ϊȷ���ĸ��壬��۵�ֵ���ٸ���
            acc=0;
            cnt=0;
            for k=1:N%�����и���j����BCmodel�ж�
                if opinion_similarMi(j,k)==1  
    %                 temp_P=coda_rule(X(j,i-1),A(k,i-1),X(k,1:i-1),A(k,1:i-1));%���뵱ǰ����j����ʷ�۵����ʷ��Ϊ
    %                 temp_P=coda_rule(X(j,i-1),A(k,i-1),X(k,1:i-1),A(k,1:i-1),a,b);%���뵱ǰ����j����ʷ�۵����ʷ��Ϊ
                    temp_P=coda_rule_const(X(j,i-1),A(k,i-1),alpha,belta);%���뵱ǰ����j�Ĺ۵����۵��ڽ�����k��̬��                
                    acc=temp_P+acc;
                    cnt=cnt+1;
                end
            end
            X(j,i)=acc/cnt;%���¸���j�Ĺ۵�ֵ
        else
            X(j,i)= X(j,i-1);
        end
    end
    %���ݸ��º�õ��Ĺ۵�����ھӼ��ж�
%     newNeighbor=isOPM(X(:,i),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
% %��Ϊ�ᷢ���ı�
%     A(X(:,i)>b,i)=1;
%     A(X(:,i)<a,i)=-1;
%     frequency_Action1(1,i)=sum(A(:,i)==1)/N;
%     frequency_ActionN1(1,i)=sum(A(:,i)==-1)/N;
%     frequency_Action0(1,i)=sum(A(:,i)==0)/N;

end
%�������ֵ������ڽ�����û������ѡ��ĸ��壬��Ҫѡ�����
lastOSM=isOPM(X(:,T),freeMatrix,epsilo_L,epsilo_R);
A=stableAction(X,lastOSM,a,b)
frequency_Action1=sum(A==1)/N;
frequency_ActionN1=sum(A==-1)/N;
frequency_Action0=sum(A==0)/N;

%shading interp
%���ƹ۵����ͼ
figure(1)
subplot(2,1,1)
for i=1:N
    plot(1:T,X(i,:),'Color',[X0(i),abs(0.7-X0(i)),abs(0.4-X0(i))]);
    hold on;
end
hold on;
plot([1 T],[a a],'*',[1 T],[b b],'*');
ylim([0 1]);
xlim([1 T]);
% title({'CODA&TTA';
%     ['a:' num2str(a) ' b:' num2str(b) ];
%     ['epsilon_L:' num2str(epsilo_L) 'epsilon_R:' num2str(epsilo_R)]})
subplot(2,1,2)
plot(1:T,frequency_Action1,1:T,frequency_ActionN1,1:T,frequency_Action0);
ylim([0 1]);
xlim([1 T]);
legend('Action=1','Action=-1','No-Action')
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
