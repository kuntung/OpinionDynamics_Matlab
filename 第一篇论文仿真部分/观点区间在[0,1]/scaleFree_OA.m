%�趨Ϊ�ޱ�������£��۵���ڽ�����ʼ�տɼ�����Ϊ���������й۵����ڸ���ɼ�
%�ٶ�������Ϊ���ᷢ���ı�
%�������Ϊ������Ŀ������ʱ�䣬�������䣬��Ϊ������ֵa,b,�Լ�CODA�۵���¹����alpha,belta
function scaleFree_OA(N,T,epsilo_L,epsilo_R,a,b,alpha,belta)
% % ʹ��ʦ�������ɵ��ڽӾ���B
% load shijieMatrix.mat;
% freeMatrix=B;
%ʹ�ù̶�����������,N=201,T=100,�ޱ������Ϊʦ�����ɵģ�X0�̶��������������
% [~, freeMatrix]=FreeScale(N);
% X0=rand(N,1); %random initial opinion profile
load testData.mat;
freeMatrix=B;
% %����ʹ���µ������ʼ���Ĺ۵�ֵ
% X0=rand(N,1);
X=zeros(N,T); %opinion profile
A=zeros(N,T);%������Ϊ����0��ʾNo-Action,1��ʾAction=1��-1��ʾAction=-1
X(:,1)=X0;
A(X(:,1)>b,1)=1;
A(X(:,1)<a,1)=-1;
% A(:,1)=randi([0,1],N,1);%��Ϊ��ʼ���������ʼ��
% frequency_Action1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
% frequency_Action1(1,1)=sum(A(:,1)==1)/N;
% 
% frequency_ActionN1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
% frequency_ActionN1(1,1)=sum(A(:,1)==-1)/N;
for i=2:T
    %���й۵����
    opinion_similarMi=isOPM(X(:,i-1),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
    Attitude=zeros(N,1);%�õ���ǰ�۵��µ�̬�Ⱦ���
    Attitude(X(:,i-1)>0.5,1)=1;
    Attitude(X(:,i-1)<0.5,1)=-1;%�۵�ֵ����0.5��̬��ΪA+��С��0.5̬��ΪA-������0.5ΪA0
    for j=1:N
        acc=0;
        cnt=0;
        for k=1:N%�����и���j����BCmodel�ж�
            if opinion_similarMi(j,k)==1  
%                 temp_P=coda_rule(X(j,i-1),A(k,i-1),X(k,1:i-1),A(k,1:i-1));%���뵱ǰ����j����ʷ�۵����ʷ��Ϊ
%                 temp_P=coda_rule(X(j,i-1),A(k,i-1),X(k,1:i-1),A(k,1:i-1),a,b);%���뵱ǰ����j����ʷ�۵����ʷ��Ϊ
                temp_P=coda_rule_const(X(j,i-1),Attitude(k,1),alpha,belta);%���뵱ǰ����j�Ĺ۵����۵��ڽ�����k��̬��                
                acc=temp_P+acc;
                cnt=cnt+1;
            end
        end
        X(j,i)=acc/cnt;%���¸���j�Ĺ۵�ֵ
    end
    %���ݸ��º�õ��Ĺ۵�����ھӼ��ж�
%     newNeighbor=isOPM(X(:,i),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
end
%case1:��Ϊ���ᷢ���仯������
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
