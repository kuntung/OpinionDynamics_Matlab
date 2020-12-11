%�趨Ϊ�ޱ�������£��۵���ڽ�����ʼ�տɼ�����Ϊ���������й۵����ڸ���ɼ�
%�������Ϊ������Ŀ������ʱ�䣬�������䣬��Ϊ������ֵa,b,�Լ�CODA�۵���¹����alpha,belta
%����'�۵���Ϊ�ᷢ���ı������'
%��alpha,beltaͨ������a,b�õ�
function scaleFreeOCA(N,T,epsilo_L,epsilo_R,a,b,alpha,belta)
%ʹ��ʦ�������ɵ��ڽӾ���B
% load B.mat;
% freeMatrix=B;
% N=200;
%ʹ�ù̶�����������,N=201,T=100,�ޱ������Ϊʦ�����ɵģ�X0�̶��������������
% [~, freeMatrix]=FreeScale(N);
% X0=rand(N,1); %random initial opinion profile
load testData.mat;
T=100;%�ӳ���������
if a<=0.25||b>=0.75
    errordlg('The parameter a and b should be assigned in the domain (0.25 0.5),(0.5,0.75) respectively.')
end
alpha=(1-b)/0.5
belta=a/0.5
% freeMatrix=B;
freeMatrix=FreeScale(N);
X=zeros(N,T); %opinion profile
% %�����ʼ��Ⱥ��۵㣬�����ж��㷨�Ƿ������Ϊ��ż��
% X0=rand(N,1);
A=zeros(N,T);%������Ϊ����0��ʾNo-Action,1��ʾAction=1��-1��ʾAction=-1
X(:,1)=X0;
A(X(:,1)>b,1)=1;
A(X(:,1)<a,1)=-1;
frequency_Action1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action1(1,1)=sum(A(:,1)==1)/N;
frequency_ActionN1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_ActionN1(1,1)=sum(A(:,1)==-1)/N;
frequency_Action0=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action0(1,1)=sum(A(:,1)==0)/N;
% A(:,1)=randi([-1,1],N,1);%��Ϊ��ʼ���������ʼ��

for i=2:T
    %���й۵����
%     opinion_similarMi=isOPM(X(:,i-1),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
    opinion_similarMi=freeMatrix;%ͬ�ޱ�����������и��������Ϊ����
    for j=1:N
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
    end
    %���ݸ��º�õ��Ĺ۵�����ھӼ��ж�
%     newNeighbor=isOPM(X(:,i),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
%��Ϊ�ᷢ���ı�
    A(X(:,i)<a,i)=-1;
    A(X(:,i)>b,i)=1;
    frequency_ActionN1(1,i)=sum(A(:,i)==-1)/N;
    frequency_Action0(1,i)=sum(A(:,i)==0)/N;
    frequency_Action1(1,i)=sum(A(:,i)==1)/N;

end
%�������ֵ������ڽ�����û������ѡ��ĸ��壬��Ҫѡ�����
% lastOSM=isOPM(X(:,T),freeMatrix,epsilo_L,epsilo_R);
lastOSM=freeMatrix;%ͬ�ޱ���������������ڸ��������Ϊ��������ʱ�۵㲻�ٿɼ�
A(:,T)=obNeighborA(X(:,T),lastOSM,A(:,T));
frequency_Action1(1,T)=sum(A(:,T)==1)/N;
frequency_ActionN1(1,T)=sum(A(:,T)==-1)/N;
frequency_Action0(1,T)=sum(A(:,T)==0)/N;

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
title('Actions and opinions can be changed')
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

%���ƹ۵�仯����ͼ
opinionX=X';%ÿ��Ϊ���壬ÿ��Ϊÿ�����嵱ǰʱ�̵Ĺ۵�ֵ
diffOpinion=diff(opinionX);
figure
for i=1:N
    plot(1:T-1,diffOpinion(:,i),'Color',[X0(i),abs(0.7-X0(i)),abs(0.4-X0(i))]);
    hold on;
end
ylim([-1 1]);
xlim([1 T-1]);
title('Opinion difference')
end
