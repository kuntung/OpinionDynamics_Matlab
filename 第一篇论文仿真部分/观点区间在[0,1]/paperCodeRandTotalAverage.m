%设定为无标度网络下，观点、行为对邻近个体始终可见
%个体观点、行为均会发生改变
%观点更新规则为HK模型
%行为采用阈值触发
%传入参数为个体数目，交流时间，信域区间，行为触发阈值a,b,以及CODA观点更新规则的alpha,belta
%进行Epoch次随机试验，然后将最终结果取平均
function [X_result,A_result,f1,f2]=paperCodeRandTotalAverage(N,T,epsilo_L,epsilo_R,a,b,alpha,belta,Epoch)
load testData.mat;
freeMatrix=B;
% %单独使用新的随机初始化的观点值
% X0=rand(N,1);%随机初始化观点值
%随机初始化观点为[-1,1]区间的值
X=zeros(N,T,Epoch); %opinion profile
A=zeros(N,T,Epoch);%生成行为矩阵，0表示No-Action,1表示Action=1，-1表示Action=-1
frequency_Action1=zeros(T,Epoch);%初始化频率为0
frequency_ActionN1=zeros(T,Epoch);%初始化频率为0
for t=1:Epoch
    %每个epoch对应三维矩阵的一层
    X(:,1,t)=X0;
    neighborM0=isOPM(X(:,1,t),freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
    A(:,1,t)=obNeighborA2(X(:,1,t),neighborM0,a,b);
    frequency_Action1(1,t)=sum(A(:,1,t)==1)/N;
    frequency_ActionN1(1,t)=sum(A(:,1,t)==-1)/N;
    for i=2:T
        %进行观点更新
        opinion_similarMi=isOPM(X(:,i-1,t),freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
        for j=1:N
            acc=0;
            cnt=0;
            for k=1:N%对所有个体j进行BCmodel判定
                if opinion_similarMi(j,k)==1  
                    temp_P=coda_rule_const(X(j,i-1,t),A(k,i-1,t),alpha,belta);%传入当前个体j的观点和其观点邻近个体k的态度   
                    acc=temp_P+acc;
                    cnt=cnt+1;
                end
            end
            X(j,i,t)=acc/cnt;%更新个体j的观点值
        end
        %根据更新后的观点值进行行为选择
        neighborM=isOPM(X(:,i,t),freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
        A(:,i,t)=obNeighborA2(X(:,i,t),neighborM,a,b);%行为不定时选择随机
    %     A(:,i)=obNeighborA2(X(:,i),neighborM,a,b);%行为不定时选择从众
        frequency_Action1(i,t)=sum(A(:,i,t)==1)/N;
        frequency_ActionN1(i,t)=sum(A(:,i,t)==-1)/N;
    end
end
X_result=sum(X,3)/Epoch;
A_result=2*(sum(A,3)>0)-1;
f1=sum(frequency_Action1,2)/Epoch;
f2=sum(frequency_ActionN1,2)/Epoch;
%shading interp
%绘制观点仿真图
% figure(1)
% subplot(2,1,1)
% for i=1:N
%     plot(1:T,X(i,:),'Color',[abs(X0(i)),abs(0.7-abs(X0(i))),abs(0.4-abs(X0(i)))]);%显示观点值的范围在[0,1]区间
% %     plot(1:T,2*X(i,:)-1,'Color',[abs(X0(i)),abs(0.7-abs(X0(i))),abs(0.4-abs(X0(i)))]);%显示观点值的范围在[-1,1]区间
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
% %绘制行为仿真图
% %plot3绘制
% figure(2)
% bar3(A)
% xlim([0 T+1]);
% ylim([0 N+1]);
% title({['a:' num2str(a) ' b:' num2str(b) ];
%     ['epsilon_L:' num2str(epsilo_L) 'epsilon_R:' num2str(epsilo_R)]})
end
