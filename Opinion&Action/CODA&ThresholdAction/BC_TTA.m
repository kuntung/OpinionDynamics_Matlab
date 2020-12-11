function BC_TTA(N,T,epsilo_L,epsilo_R,a,b)
%更新迭代观点
X=zeros(N,T); %opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
% X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%生成行为矩阵
X(:,1)=X0;
% A(:,1)=(X0>=0.5);%行为初始化,根据自身观点
A(:,1)=TTA(X0,isNeighbor(X0,epsilo_L,epsilo_R),a,b);
% A(:,1)=randi([0,1],N,1);%行为初始化，随机初始化
frequency_Action=zeros(1,T);%初始化频率为0
frequency_Action(1,1)=sum(A(:,1)==1)/N;
for i=2:T
    %进行观点更新
    oldNeighbor=isNeighbor(X(:,i-1),epsilo_L,epsilo_R);
    for j=1:N
        acc=0;
        cnt=0;
        for k=1:N%对所有个体j进行BCmodel判定
            if oldNeighbor(j,k)==1  
%                 temp_P=coda_rule(X(j,i-1),A(k,i-1),X(k,1:i-1),A(k,1:i-1));%传入当前个体j的历史观点和历史行为
                temp_P=coda_rule(X(j,i-1),A(k,i-1),X(k,1:i-1),A(k,1:i-1),a,b);%传入当前个体j的历史观点和历史行为
                acc=temp_P+acc;
                cnt=cnt+1;
            end
        end
        if sum(oldNeighbor(j,:))==0
            X(j,i)=X(j,i-1);
        else
            X(j,i)=acc/cnt;
        end
    end
    %根据更新后得到的观点进行邻居集判断
    newNeighbor=isNeighbor(X(:,i),epsilo_L,epsilo_R);
    A(:,i)=TTA(X(:,i),newNeighbor,a,b);%采用阈值触发行为机制，对当前观点进行行为选择
    frequency_Action(1,i)=sum(A(:,i)==1)/N;%计算当前Action=1比例
end

%shading interp
%绘制观点仿真图
figure(1)
subplot(2,1,1)
for i=1:N
    plot(0:T-1,X(i,:),'Color',[X0(i),abs(0.7-X0(i)),abs(0.4-X0(i))]);
    hold on;
end
title({'CODA&TTA';
    ['a:' num2str(a) ' b:' num2str(b) ];
    ['epsilon_L:' num2str(epsilo_L) 'epsilon_R:' num2str(epsilo_R)]})
subplot(2,1,2)
plot(0:T-1,frequency_Action,0:T-1,1-frequency_Action);
ylim([0 1]);
legend('Action=1','Action=0')
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
