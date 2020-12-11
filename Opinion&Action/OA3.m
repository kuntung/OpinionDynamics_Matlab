%在对称、非对称置信区间的情形下，考虑用户行为与观点的动态变化
%其中初始观点随机给定
%观点更新规则考虑非对称的置信度
%初始行为单独随机给定
%情形3：邻居
function OA3(N,T,epsilo_L,epsilo_R)
%生成行为触发阈值
H=randi([1,3],N,1);
H(H==1)=0.7;
H(H==2)=0.7;
H(H==3)=0.7;
X=zeros(N,T); %opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
% X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%生成行为矩阵
X(:,1)=X0;
%初始行为随机初始化
% A(:,1)=randi([0,1],N,1);
A(:,1)=init_Action(X0,0.3,0.7);
frequency_Action=zeros(1,T);%初始化频率为0
frequency_Action(1,1)=sum(A(:,1))/N;
same_value=zeros(N,T);%初始化每个agent每个迭代周期的邻居ACTION观测值
for i=2:T
    for j=1:N
        acc=0; 
        cnt=0;
        act_same=0;
        temp_P=zeros(N,1);
        for k=1:N
            dis=X(k,i-1)-X(j,i-1);
            %邻近集确立
            if (dis<=epsilo_R) && (dis>=-epsilo_L)
                temp_P(k)=coda_rule()
                acc=X(k,i-1)+acc;
                cnt=cnt+1;
                %判断agent更偏好哪种Action
                %偏好于Action=1
                if X(j,i-1)>=0.5
                    %判断邻居的Action
                                                                                                                                                              if A(k,i-1)==1
                        act_same=act_same+1;
                    end
                end
                %偏好于Action=0
                if X(j,i-1)<0.5
                    %判断邻居的Action
%                     if A(k,i-1)==0&&X(k,i-1)<=0.5
                    if A(k,i-1)==0
                        act_same=act_same+1;
                    end
                end
            end
        end
        X(j,i)=acc/cnt;
        same_value(j,i)=act_same/cnt;%计算当前迭代周期，agent的邻居观测结果
    end
    %对当前迭代周期的每个agent进行Action判定
    for t=1:N
        %对于观点偏向于Action=1的agent
        if X(t,i)>=0.5&&same_value(t,i)>=H(t)
            A(t,i)=1;
        else
            A(t,i)=0;
        end
        %对于观点偏向于Action=0的agent
        if X(t,i)<0.5&&same_value(t,i)>=H(t)
            A(t,i)=0;
        else
            A(t,i)=1;
        end
    end
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
    ['响应比例: ' num2str(H(1))]})
%绘制行为仿真图
figure(2)
% subplot(2,1,1)
% for i=1:N
%     plot(0:T-1,A(i,:),'-o');
%     hold on 
% end
% title('情形2：Action变化曲线')


%plot3绘制
bar3(A)
xlim([0 T+1]);
ylim([0 N+1]);
title({['agent数:' num2str(N) ' 迭代次数:' num2str(T)];
    ['左区间:' num2str(epsilo_L) ' 右区间:' num2str(epsilo_R)];
    ['响应比例: ' num2str(H(1))]})
end

