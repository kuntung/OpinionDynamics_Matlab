%在对称、非对称置信区间的情形下，考虑用户行为与观点的动态变化
%其中初始观点随机给定
%观点更新规则考虑非对称的置信度
%初始行为单独随机给定
%情形4：风险型决策
function OA4(N,T,epsilo_L,epsilo_R)
%生成决策风险表
%---------------
%ACTION=1 5     3
%ACTION=0 4     6
lamda=[-2 5;4 1];
%生成行为触发阈值
% H=randi([1,3],N,1);
% H(H==1)=0.3;
% H(H==2)=0.3;
% H(H==3)=0.3;
X=zeros(N,T); %opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
% X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%生成行为矩阵
X(:,1)=X0;
A(:,1)=randi([0,1],N,1);
frequency_Action=zeros(1,T);%初始化频率为0
frequency_Action(1,1)=sum(A(:,1))/N;
% same_value=zeros(N,T);%初始化每个agent每个迭代周期的邻居ACTION观测值
for i=2:T
    A_temp=zeros(N,1);
    for j=1:N
        acc=0; 
        cnt=0;
        for k=1:N
            dis=X(k,i-1)-X(j,i-1);
            %邻近集确立
            if (dis<=epsilo_R) && (dis>=-epsilo_L)
                acc=X(k,i-1)+acc;
                cnt=cnt+1;
            end
        end
        X(j,i)=acc/cnt;
%         same_value(j,i)=act_same/cnt;%计算当前迭代周期，agent的邻居观测结果
    end
    %计算风险
    Temp=[X(:,i) 1-X(:,i)];
    R=Temp*lamda';
    disp(R)
    for k=1:N
        ind=find(R(k,:)==min(R(k,:)))-1;
        A_temp(k,1)=ind(1);
    end
    A(:,i)=A_temp;
    frequency_Action(1,i)=sum(A(:,i))/N;
end
%绘制观点仿真图
figure(1)
subplot(2,1,1)
for i=1:N
    plot(0:T-1,X(i,:),'Color',[X0(i),abs(0.7-X0(i)),abs(0.4-X0(i))]);
    hold on;
end
title({'情形3：观点响应图';
    ['agent数:' num2str(N) ' 迭代次数:' num2str(T) ' 左区间:' num2str(epsilo_L) ' 右区间:' num2str(epsilo_R)]})
subplot(2,1,2)
plot(0:T-1,frequency_Action,0:T-1,1-frequency_Action);
ylim([0 1]);
legend('Action=1','Action=0')
title({['agent数:' num2str(N) ' 迭代次数:' num2str(T)];
    ['左区间:' num2str(epsilo_L) ' 右区间:' num2str(epsilo_R)];
    ['风险表: [-2 5;4 1]']})
%绘制行为仿真图
figure(2)
%plot3绘制
bar3(A)
xlim([0 T+1]);
ylim([0 N+1]);
title({['agent数:' num2str(N) ' 迭代次数:' num2str(T)];
    ['左区间:' num2str(epsilo_L) ' 右区间:' num2str(epsilo_R)];
    ['风险表: [-2 5;4 1]']})
end

