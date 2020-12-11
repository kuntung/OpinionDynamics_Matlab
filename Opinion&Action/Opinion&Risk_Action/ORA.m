%在对称、非对称置信区间的情形下，考虑用户行为与观点的动态变化
%其中初始观点均匀给定
%观点更新规则考虑非对称的置信度
%初始行为采用分区间给定
%H-K模型下的风险型决策&CODA观点更新
function ORA(N,T,epsilo_L,epsilo_R)
%生成决策风险表
%----典型示例1------
%ACTION=1 0     1
%ACTION=0 1     0
%上表表示仅考虑agent的偏好Pi
% lamda=[0 1;1 0];
lamda=[3 4;7 2]; 

% lamda=[-2 4;6 -4];
% lamda=[2 5;6 3];%一样的观点一致性。最终行为比例相同
% lamda=[6 7;8 3];%满足约束3，但是观点及行为均不相似

% %----典型示例2------
% %ACTION=1 3     1
% %ACTION=0 2     5
% lamda=[3 2;1 5]; 

% lamda=[0 6;5 1]; 


X=zeros(N,T); %opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
% X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%生成行为矩阵
X(:,1)=X0;
% A(:,1)=init_Act(X0,0.3,0.7); %分段初始化Action
A(:,1)=riskyAction(X0',lamda);%风险型决策初始化
frequency_Action=zeros(1,T);%初始化频率为0
frequency_Action(1,1)=sum(A(:,1))/N;
% same_value=zeros(N,T);%初始化每个agent每个迭代周期的邻居ACTION观测值
for i=2:T
    for j=1:N
        acc=0; 
        cnt=0;
        for k=1:N
            dis=X(k,i-1)-X(j,i-1);
            %邻近集确立
            if (dis<=epsilo_R) && (dis>=-epsilo_L)
                if k~=j
%                     temp_P=daco_rule(X(j,i-1),X(k,1:i-1),A(k,1:i-1));
                    temp_P=coda_rule(X(j,i-1),X(j,1:i-1),A(j,1:i-1));
                    acc=temp_P+acc;
                    cnt=cnt+1;
                end
            end
        end
        X(j,i)=acc/cnt;
    end
    A(:,i)=riskyAction(X(:,i),lamda);
    frequency_Action(1,i)=sum(A(:,i))/N;
end
%绘制观点仿真图
figure(1)
subplot(2,1,1)
for i=1:N
    plot(0:T-1,X(i,:),'Color',[X0(i),abs(0.7-X0(i)),abs(0.4-X0(i))]);
    hold on;
end
title({'CODA&风险决策';
    ['agent数:' num2str(N) ' 迭代次数:' num2str(T) ];
    ['左区间:' num2str(epsilo_L) '右区间:' num2str(epsilo_R)]})
subplot(2,1,2)
plot(0:T-1,frequency_Action,0:T-1,1-frequency_Action);
ylim([0 1]);
legend('Action=1','Action=0')
title({['agent数:' num2str(N) ' 迭代次数:' num2str(T)];
    ['左区间:' num2str(epsilo_L) ' 右区间:' num2str(epsilo_R)];
    ['风险表: [' num2str(lamda(1)) ' ' num2str(lamda(3)) ';' num2str(lamda(2))  ' ' num2str(lamda(4)) ']']})
%绘制行为仿真图
figure(2)
%plot3绘制
bar3(A)
xlim([0 T+1]);
ylim([0 N+1]);
title({['agent数:' num2str(N) ' 迭代次数:' num2str(T)];
    ['左区间:' num2str(epsilo_L) ' 右区间:' num2str(epsilo_R)];
    ['风险表: [' num2str(lamda(1)) ' ' num2str(lamda(3)) ';' num2str(lamda(2))  ' ' num2str(lamda(4)) ']']})
end