%�趨Ϊ�ޱ�������£��۵㡢��Ϊ���ڽ�����ʼ�տɼ�
%����۵㡢��Ϊ���ᷢ���ı�
%�۵���¹���ΪHKģ��
%��Ϊ������ֵ����
%�������Ϊ������Ŀ������ʱ�䣬�������䣬��Ϊ������ֵa,b,�Լ�CODA�۵���¹����alpha,belta
%��Ϊ��ȷ��ʱ��ѡ�����
%��������Ϊѡ��ĸ��壬����101���ظ����飬ÿ��T��ƽ��
function paperCodeRand(N,T,epsilo_L,epsilo_R,a,b,alpha,belta,Epoch)
if mod(Epoch,2)==0
    error('Epoch must be setted as a odd number.')
end
load testData.mat;
freeMatrix=B;
% %����ʹ���µ������ʼ���Ĺ۵�ֵ
% X0=rand(N,1);%�����ʼ���۵�ֵ
X=zeros(N,T); %opinion profile
A=zeros(N,T);%������Ϊ����0��ʾNo-Action,1��ʾAction=1��-1��ʾAction=-1
X(:,1)=X0;
neighborM0=isOPM(X(:,1),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
A(:,1)=obNeighborA1(X(:,1),neighborM0,a,b);
% A(:,1)=obNeighborA2(X(:,1),neighborM0,a,b);
% A(:,1)=randi([0,1],N,1);%��Ϊ��ʼ���������ʼ��
frequency_Action1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_Action1(1,1)=sum(A(:,1)==1)/N;
frequency_ActionN1=zeros(1,T);%��ʼ��Ƶ��Ϊ0
frequency_ActionN1(1,1)=sum(A(:,1)==-1)/N;

for i=2:T
    %���й۵����
    opinion_similarMi=isOPM(X(:,i-1),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
    epochX=genArbitraryMatrix(N,Epoch,-1);%����ÿ�����������У���������epoch������õ��Ĺ۵�ֵ
    epochA=zeros(N,Epoch);
    for t=1:Epoch
        for j=1:N
            acc=0;
            cnt=0;
            for k=1:N%�����и���j����BCmodel�ж�
                if opinion_similarMi(j,k)==1  
                    temp_P=coda_rule_const(X(j,i-1),A(k,i-1),alpha,belta);%���뵱ǰ����j�Ĺ۵����۵��ڽ�����k��̬��   
    %                 temp_P=coda_rule_const_minus(X(j,i-1),A(k,i-1),alpha,belta);%���뵱ǰ����j�Ĺ۵����۵��ڽ�����k��̬��,�۵�ֵ����Ϊ[-1,1]   
                    acc=temp_P+acc;
                    cnt=cnt+1;
                end
            end
            epochX(j,t)=acc/cnt;%���¸���j�Ĺ۵�ֵ
        end
        neighborM=isOPM(epochX(:,t),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
        epochA(:,t)=obNeighborA1(epochX(:,t),neighborM,a,b);%��Ϊ����ʱѡ�����
    end
    X(:,i)=sum(epochX,2)/Epoch;
    A(:,i)=2*(sum(epochA,2)>0)-1;
    frequency_Action1(1,i)=sum(A(:,i)==1)/N;
    frequency_ActionN1(1,i)=sum(A(:,i)==-1)/N;
end


%���ƹ۵����ͼ
figure(1)
subplot(2,1,1)
for i=1:N
    plot(1:T,X(i,:),'Color',[abs(X0(i)),abs(0.7-abs(X0(i))),abs(0.4-abs(X0(i)))]);
    hold on;
end
ylim([0 1]);
xlim([1 T]);
xlabel('Time t')
ylabel('Opinions p_{i,t}')
% title({'CODA&TTA';
%     ['a:' num2str(a) ' b:' num2str(b) ];
%     ['epsilon_L:' num2str(epsilo_L) 'epsilon_R:' num2str(epsilo_R)]})
subplot(2,1,2)
plot(1:T,frequency_Action1,1:T,frequency_ActionN1);
ylim([0 1]);
xlim([1 T]);
xlabel('Time t')
legend('Percentage of choosing A','Percentage of choosing B')
% title({['a:' num2str(a) ' b:' num2str(b) ];
%     ['epsilon_L:' num2str(epsilo_L) 'epsilo_R:' num2str(epsilo_R)]})
%������Ϊ����ͼ
%plot3����
% figure(2)
% bar3(A)
% xlim([0 T+1]);
% ylim([0 N+1]);
% title({['a:' num2str(a) ' b:' num2str(b) ];
%     ['epsilon_L:' num2str(epsilo_L) 'epsilon_R:' num2str(epsilo_R)]})
end
