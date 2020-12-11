%�趨Ϊ�ޱ�������£��۵㡢��Ϊ���ڽ�����ʼ�տɼ�
%����۵㡢��Ϊ���ᷢ���ı�
%�۵���¹���ΪHKģ��
%��Ϊ������ֵ����
%�������Ϊ������Ŀ������ʱ�䣬�������䣬��Ϊ������ֵa,b,�Լ�CODA�۵���¹����alpha,belta
%��Ϊ��ȷ��ʱ��ѡ����ڣ�����Լ��۵�
function [X_result,A_result]=paperCodeNonRand(N,T,epsilo_L,epsilo_R,a,b,alpha,belta)
load testData.mat;
freeMatrix=NB;
% %����ʹ���µ������ʼ���Ĺ۵�ֵ
% X0=rand(N,1);%�����ʼ���۵�ֵ
%�����ʼ���۵�Ϊ[-1,1]�����ֵ
% X0=unifrnd(0,1,N,1);
X=zeros(N,T); %opinion profile
X(:,1)=X0unif;
% X(:,1)=X0;
A=zeros(N,T);%������Ϊ����0��ʾNo-Action,1��ʾAction=1��-1��ʾAction=-1
neighborM0=isOPM(X(:,1),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
A(:,1)=obNeighborA2(X(:,1),neighborM0,a,b);
% A(:,1)=obNeighborA2(X(:,1),neighborM0,a,b);
% A(:,1)=randi([0,1],N,1);%��Ϊ��ʼ���������ʼ��
frequency_Action1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action1(1,1)=sum(A(:,1)==1)/N;
frequency_ActionN1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_ActionN1(1,1)=sum(A(:,1)==-1)/N;
for i=2:T
    %���й۵����
    opinion_similarMi=isOPM(X(:,i-1),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
    for j=1:N
        acc=0;
        cnt=0;
        for k=1:N%�����и���j����BCmodel�ж�
            if opinion_similarMi(j,k)==1  
                temp_P=coda_rule_const(X(j,i-1),A(k,i-1),alpha,belta);%���뵱ǰ����j�Ĺ۵����۵��ڽ�����k��̬��   
                acc=temp_P+acc;
                cnt=cnt+1;
            end
        end
        if cnt==0
            X(j,i)=X(j,i-1);
        else
            X(j,i)=acc/cnt;%���¸���j�Ĺ۵�ֵ
        end
    end
    %���ݸ��º�Ĺ۵�ֵ������Ϊѡ��
    neighborM=isOPM(X(:,i),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
    A(:,i)=obNeighborA2(X(:,i),neighborM,a,b);%��Ϊ����ʱѡ�����
%     A(:,i)=obNeighborA2(X(:,i),neighborM,a,b);%��Ϊ����ʱѡ�����
    frequency_Action1(1,i)=sum(A(:,i)==1)/N;
    frequency_ActionN1(1,i)=sum(A(:,i)==-1)/N;
end
X_result=X;
A_result=A;
%shading interp
%���ƹ۵����ͼ
figure(1)
subplot(2,1,1)
for i=1:N
    plot(1:T,X(i,:),'Color',[abs(X0unif(i)),abs(0.7-abs(X0unif(i))),abs(0.4-abs(X0unif(i)))]);%��ʾ�۵�ֵ�ķ�Χ��[0,1]����
%     plot(1:T,2*X(i,:)-1,'Color',[abs(X0(i)),abs(0.7-abs(X0(i))),abs(0.4-abs(X0(i)))]);%��ʾ�۵�ֵ�ķ�Χ��[-1,1]����
    hold on;
end
xlim([1 T]);
xlabel('Time t')
ylabel('Opinions')

subplot(2,1,2)
plot(1:T,frequency_Action1,1:T,frequency_ActionN1);
ylim([0 1]);
xlim([1 T]);
xlabel('Time t')
legend('Percentage of choosing A','Percentage of choosing B')

% figure
% h1=histogram(X(:,1),'BinWidth',0.1);
% hold on;
% h2=histogram(X(:,T),'BinWidth',0.1);
% grid on;
% set(gca,'YTick',[0:10:N]);
% set(gca,'XTick',[0:epsilo_L:1]);%����Ҫ��ʾ����̶�
% legend('Initial Opinion','Final Opinion');
% ylabel('The number of agents');
% xlabel('Opinion range');

end
