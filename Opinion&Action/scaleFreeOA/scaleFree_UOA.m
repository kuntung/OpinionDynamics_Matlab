%设定为无标度网络下，观点对邻近个体始终可见，行为仅对网络中观点相邻个体可见
%传入参数为个体数目，交流时间，信域区间，行为触发阈值a,b,以及CODA观点更新规则的alpha,belta
%观点、行为确定后不会发生改变
function scaleFree_UOA(N,T,epsilo_L,epsilo_R,a,b,alpha,belta)
%使用师姐所生成的邻接矩阵B
% load B.mat;
% freeMatrix=B;
% N=200;
%使用自己生成的无标度网络邻接矩阵
[~, freeMatrix]=FreeScale(N);
X=zeros(N,T); %opinion profile
% X0=0:1/(N-1):1; %uniform initial opinion profile
X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%生成行为矩阵，0表示No-Action,1表示Action=1，-1表示Action=-1
% freeMatrix=FreeScale(N);%生成个体数目为N的无标度网络邻接矩阵
X(:,1)=X0;
A(X(:,1)>b,1)=1;
A(X(:,1)<a,1)=-1;

% A(:,1)=randi([0,1],N,1);%行为初始化，随机初始化
frequency_Action1=zeros(1,T);%初始化频率为0
frequency_Action1(1,1)=sum(A(:,1)==1)/N;
frequency_ActionN1=zeros(1,T);%初始化频率为0
frequency_ActionN1(1,1)=sum(A(:,1)==-1)/N;
frequency_Action0=zeros(1,T);%初始化频率为0
frequency_Action0(1,1)=sum(A(:,1)==0)/N;


for i=2:T
    %进行观点更新
    opinion_similarMi=isOPM(X(:,i-1),freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
    for j=1:N
        if A(j,i-1)==0%对于行为确定的个体，其观点值不再更新
            acc=0;
            cnt=0;
            for k=1:N%对所有个体j进行BCmodel判定
                if opinion_similarMi(j,k)==1  
    %                 temp_P=coda_rule(X(j,i-1),A(k,i-1),X(k,1:i-1),A(k,1:i-1));%传入当前个体j的历史观点和历史行为
    %                 temp_P=coda_rule(X(j,i-1),A(k,i-1),X(k,1:i-1),A(k,1:i-1),a,b);%传入当前个体j的历史观点和历史行为
                    temp_P=coda_rule_const(X(j,i-1),A(k,i-1),alpha,belta);%传入当前个体j的观点和其观点邻近个体k的态度                
                    acc=temp_P+acc;
                    cnt=cnt+1;
                end
            end
            X(j,i)=acc/cnt;%更新个体j的观点值
        else
            X(j,i)= X(j,i-1);
        end
    end
    %根据更新后得到的观点进行邻居集判断
%     newNeighbor=isOPM(X(:,i),freeMatrix,epsilo_L,epsilo_R);%得到每个个体的观点邻近矩阵
% %行为会发生改变
%     A(X(:,i)>b,i)=1;
%     A(X(:,i)<a,i)=-1;
%     frequency_Action1(1,i)=sum(A(:,i)==1)/N;
%     frequency_ActionN1(1,i)=sum(A(:,i)==-1)/N;
%     frequency_Action0(1,i)=sum(A(:,i)==0)/N;

end
%对于那种迭代周期结束后没有做出选择的个体，需要选择从众
lastOSM=isOPM(X(:,T),freeMatrix,epsilo_L,epsilo_R);
A=stableAction(X,lastOSM,a,b)
frequency_Action1=sum(A==1)/N;
frequency_ActionN1=sum(A==-1)/N;
frequency_Action0=sum(A==0)/N;

%shading interp
%绘制观点仿真图
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
%绘制行为仿真图
%plot3绘制
figure(2)
bar3(A)
xlim([0 T+1]);
ylim([0 N+1]);
title({['a:' num2str(a) ' b:' num2str(b) ];
    ['epsilon_L:' num2str(epsilo_L) 'epsilon_R:' num2str(epsilo_R)]})

end
