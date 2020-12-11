%设定为无标度网络下，观点、行为对邻近个体始终可见
%个体观点、行为均会发生改变
%观点更新规则为HK模型
%行为采用阈值触发
%传入参数为个体数目，交流时间，信域区间，行为触发阈值a,b,以及CODA观点更新规则的alpha,belta
%行为不确定时，选择随机
%针对随机行为选择的个体，进行101次重复试验，每个T求平均
function paperCodeRand(N,T,epsilo_L,epsilo_R,a,b,alpha,belta,Epoch)
if mod(Epoch,2)==0
    error('Epoch must be setted as a odd number.')
end
load testData.mat;
freeMatrix=B;
% %单独使用新的随机初始化的观点值
% X0=rand(N,1);%随机初始化观点值
X=zeros(N,T); %opinion profile
A=zeros(N,T);%生成行为矩阵，0表示No-Action,1表示Action=1，-1表示Action=-1
X(:,1)=X0;
neighborM0=isOPM(X(:,1),freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
A(:,1)=obNeighborA1(X(:,1),neighborM0,a,b);
% A(:,1)=obNeighborA2(X(:,1),neighborM0,a,b);
% A(:,1)=randi([0,1],N,1);%行为初始化，随机初始化
frequency_Action1=zeros(1,T);%初始化频率为0
frequency_Action1(1,1)=sum(A(:,1)==1)/N;
frequency_ActionN1=zeros(1,T);%初始化频率为0
frequency_ActionN1(1,1)=sum(A(:,1)==-1)/N;

for i=2:T
    %进行观点更新
    opinion_similarMi=isOPM(X(:,i-1),freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
    epochX=genArbitraryMatrix(N,Epoch,-1);%生成每个迭代周期中，用来保存epoch个随机得到的观点值
    epochA=zeros(N,Epoch);
    for t=1:Epoch
        for j=1:N
            acc=0;
            cnt=0;
            for k=1:N%对所有个体j进行BCmodel判定
                if opinion_similarMi(j,k)==1  
                    temp_P=coda_rule_const(X(j,i-1),A(k,i-1),alpha,belta);%传入当前个体j的观点和其观点邻近个体k的态度   
    %                 temp_P=coda_rule_const_minus(X(j,i-1),A(k,i-1),alpha,belta);%传入当前个体j的观点和其观点邻近个体k的态度,观点值区间为[-1,1]   
                    acc=temp_P+acc;
                    cnt=cnt+1;
                end
            end
            epochX(j,t)=acc/cnt;%更新个体j的观点值
        end
        neighborM=isOPM(epochX(:,t),freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
        epochA(:,t)=obNeighborA1(epochX(:,t),neighborM,a,b);%行为不定时选择随机
    end
    X(:,i)=sum(epochX,2)/Epoch;
    A(:,i)=2*(sum(epochA,2)>0)-1;
    frequency_Action1(1,i)=sum(A(:,i)==1)/N;
    frequency_ActionN1(1,i)=sum(A(:,i)==-1)/N;
end


%绘制观点仿真图
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
%绘制行为仿真图
%plot3绘制
% figure(2)
% bar3(A)
% xlim([0 T+1]);
% ylim([0 N+1]);
% title({['a:' num2str(a) ' b:' num2str(b) ];
%     ['epsilon_L:' num2str(epsilo_L) 'epsilon_R:' num2str(epsilo_R)]})
end
