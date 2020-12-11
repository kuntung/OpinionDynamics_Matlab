%设定为无标度网络下，观点、行为对邻近个体始终可见
%个体观点、行为均会发生改变
%观点更新规则为HK模型
%行为采用阈值触发
%传入参数为个体数目，交流时间，信域区间，行为触发阈值a,b,以及CODA观点更新规则的alpha,belta
%行为不确定时，选择从众，结合自己观点
function [X_result,A_result]=paperCodeNonRand(N,T,epsilo_L,epsilo_R,a,b,alpha,belta)
load testData.mat;
freeMatrix=NB;
% %单独使用新的随机初始化的观点值
% X0=rand(N,1);%随机初始化观点值
%随机初始化观点为[-1,1]区间的值
% X0=unifrnd(0,1,N,1);
X=zeros(N,T); %opinion profile
X(:,1)=X0unif;
% X(:,1)=X0;
A=zeros(N,T);%生成行为矩阵，0表示No-Action,1表示Action=1，-1表示Action=-1
neighborM0=isOPM(X(:,1),freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
A(:,1)=obNeighborA2(X(:,1),neighborM0,a,b);
% A(:,1)=obNeighborA2(X(:,1),neighborM0,a,b);
% A(:,1)=randi([0,1],N,1);%行为初始化，随机初始化
frequency_Action1=zeros(1,T);%初始化频率为0
frequency_Action1(1,1)=sum(A(:,1)==1)/N;
frequency_ActionN1=zeros(1,T);%初始化频率为0
frequency_ActionN1(1,1)=sum(A(:,1)==-1)/N;
for i=2:T
    %进行观点更新
    opinion_similarMi=isOPM(X(:,i-1),freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
    for j=1:N
        acc=0;
        cnt=0;
        for k=1:N%对所有个体j进行BCmodel判定
            if opinion_similarMi(j,k)==1  
                temp_P=coda_rule_const(X(j,i-1),A(k,i-1),alpha,belta);%传入当前个体j的观点和其观点邻近个体k的态度   
                acc=temp_P+acc;
                cnt=cnt+1;
            end
        end
        if cnt==0
            X(j,i)=X(j,i-1);
        else
            X(j,i)=acc/cnt;%更新个体j的观点值
        end
    end
    %根据更新后的观点值进行行为选择
    neighborM=isOPM(X(:,i),freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
    A(:,i)=obNeighborA2(X(:,i),neighborM,a,b);%行为不定时选择随机
%     A(:,i)=obNeighborA2(X(:,i),neighborM,a,b);%行为不定时选择从众
    frequency_Action1(1,i)=sum(A(:,i)==1)/N;
    frequency_ActionN1(1,i)=sum(A(:,i)==-1)/N;
end
X_result=X;
A_result=A;
%shading interp
%绘制观点仿真图
figure(1)
subplot(2,1,1)
for i=1:N
    plot(1:T,X(i,:),'Color',[abs(X0unif(i)),abs(0.7-abs(X0unif(i))),abs(0.4-abs(X0unif(i)))]);%显示观点值的范围在[0,1]区间
%     plot(1:T,2*X(i,:)-1,'Color',[abs(X0(i)),abs(0.7-abs(X0(i))),abs(0.4-abs(X0(i)))]);%显示观点值的范围在[-1,1]区间
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
% set(gca,'XTick',[0:epsilo_L:1]);%设置要显示坐标刻度
% legend('Initial Opinion','Final Opinion');
% ylabel('The number of agents');
% xlabel('Opinion range');

end
