%�趨Ϊ�ޱ�������£��۵㡢��Ϊ���ڽ�����ʼ�տɼ�
%����۵㡢��Ϊ���ᷢ���ı�
%�۵���¹���ΪHKģ��
%��Ϊ������ֵ����
%�������Ϊ������Ŀ������ʱ�䣬�������䣬��Ϊ������ֵa,b,�Լ�CODA�۵���¹����alpha,belta
%����Epoch��������飬Ȼ�����ս��ȡƽ��
function [X_result,A_result,f1,f2]=paperCodeRandTotalAverage(N,T,epsilo_L,epsilo_R,a,b,alpha,belta,Epoch)
load testData.mat;
freeMatrix=B;
% %����ʹ���µ������ʼ���Ĺ۵�ֵ
% X0=rand(N,1);%�����ʼ���۵�ֵ
%�����ʼ���۵�Ϊ[-1,1]�����ֵ
X=zeros(N,T,Epoch); %opinion profile
A=zeros(N,T,Epoch);%������Ϊ����0��ʾNo-Action,1��ʾAction=1��-1��ʾAction=-1
frequency_Action1=zeros(T,Epoch);%��ʼ��Ƶ��Ϊ0
frequency_ActionN1=zeros(T,Epoch);%��ʼ��Ƶ��Ϊ0
for t=1:Epoch
    %ÿ��epoch��Ӧ��ά�����һ��
    X(:,1,t)=X0;
    neighborM0=isOPM(X(:,1,t),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
    A(:,1,t)=obNeighborA2(X(:,1,t),neighborM0,a,b);
    frequency_Action1(1,t)=sum(A(:,1,t)==1)/N;
    frequency_ActionN1(1,t)=sum(A(:,1,t)==-1)/N;
    for i=2:T
        %���й۵����
        opinion_similarMi=isOPM(X(:,i-1,t),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
        for j=1:N
            acc=0;
            cnt=0;
            for k=1:N%�����и���j����BCmodel�ж�
                if opinion_similarMi(j,k)==1  
                    temp_P=coda_rule_const(X(j,i-1,t),A(k,i-1,t),alpha,belta);%���뵱ǰ����j�Ĺ۵����۵��ڽ�����k��̬��   
                    acc=temp_P+acc;
                    cnt=cnt+1;
                end
            end
            X(j,i,t)=acc/cnt;%���¸���j�Ĺ۵�ֵ
        end
        %���ݸ��º�Ĺ۵�ֵ������Ϊѡ��
        neighborM=isOPM(X(:,i,t),freeMatrix,epsilo_L,epsilo_R);%�õ�ÿ������Ĺ۵��ڽ�����
        A(:,i,t)=obNeighborA2(X(:,i,t),neighborM,a,b);%��Ϊ����ʱѡ�����
    %     A(:,i)=obNeighborA2(X(:,i),neighborM,a,b);%��Ϊ����ʱѡ�����
        frequency_Action1(i,t)=sum(A(:,i,t)==1)/N;
        frequency_ActionN1(i,t)=sum(A(:,i,t)==-1)/N;
    end
end
X_result=sum(X,3)/Epoch;
A_result=2*(sum(A,3)>0)-1;
f1=sum(frequency_Action1,2)/Epoch;
f2=sum(frequency_ActionN1,2)/Epoch;
%shading interp
%���ƹ۵����ͼ
% figure(1)
% subplot(2,1,1)
% for i=1:N
%     plot(1:T,X(i,:),'Color',[abs(X0(i)),abs(0.7-abs(X0(i))),abs(0.4-abs(X0(i)))]);%��ʾ�۵�ֵ�ķ�Χ��[0,1]����
% %     plot(1:T,2*X(i,:)-1,'Color',[abs(X0(i)),abs(0.7-abs(X0(i))),abs(0.4-abs(X0(i)))]);%��ʾ�۵�ֵ�ķ�Χ��[-1,1]����
%     hold on;
% end
% xlim([1 T]);
% % title({'CODA&TTA';
% %     ['a:' num2str(a) ' b:' num2str(b) ];
% %     ['epsilon_L:' num2str(epsilo_L) 'epsilon_R:' num2str(epsilo_R)]})
% subplot(2,1,2)
% plot(1:T,frequency_Action1,1:T,frequency_ActionN1);
% ylim([0 1]);
% xlim([1 T]);
% legend('Action=A','Action=B')
% title({['a:' num2str(a) ' b:' num2str(b) ];
%     ['epsilon_L:' num2str(epsilo_L) 'epsilo_R:' num2str(epsilo_R)]})
% %������Ϊ����ͼ
% %plot3����
% figure(2)
% bar3(A)
% xlim([0 T+1]);
% ylim([0 N+1]);
% title({['a:' num2str(a) ' b:' num2str(b) ];
%     ['epsilon_L:' num2str(epsilo_L) 'epsilon_R:' num2str(epsilo_R)]})
end
