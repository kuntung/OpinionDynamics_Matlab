%在非对称置信区间的情形下，考虑用户行为与观点的动态变化
%其中初始观点随机给定
%观点更新规则考虑非对称的置信度
%初始行为单独随机给定
%用户行为仅根据观点值变化
%情形1,行为触发hj相同
function OA1(N,T,epsilo_L,epsilo_R,epsilo_Act)
X=zeros(N,T); %opinion profile
X0=0:1/(N-1):1; %uniform initial opinion profile
% X0=rand(N,1); %random initial opinion profile
A=zeros(N,T);%生成行为矩阵
X(:,1)=X0;
for t=1:N
    if X(t,1)>=epsilo_Act
        A(t,1)=1;
    end
end
frequency_Action=zeros(1,T);%初始化频率为0
frequency_Action(1,1)=sum(A(:,1))/N;
for i=2:T
    for j=1:N
        acc=0; 
        cnt=0;
        for k=1:N
            dis=X(k,i-1)-X(j,i-1);
            if (dis<=epsilo_R) && (dis>=-epsilo_L)
                acc=X(k,i-1)+acc;
                cnt=cnt+1;
            end
        end
        X(j,i)=acc/cnt;
    end
    for t=1:N
       if X(t,i)>=epsilo_Act
            A(t,i)=1;
       end
    end
    frequency_Action(1,i)=sum(A(:,i))/N;
end
%绘制观点仿真图
figure(1)
% subplot(3,1,1)
for i=1:N
    plot(0:T-1,X(i,:),'Color',[X0(i),abs(0.7-X0(i)),abs(0.4-X0(i))]);
    hold on 
end
title({'情形2：观点响应图';
    ['agent数:' num2str(N) ' 迭代次数:' num2str(T) ' 左区间:' num2str(epsilo_L) ' 右区间:' num2str(epsilo_R)]})
% title('N='+N+'T='+T+'epsiloL='+epsilo_Act)
% 
%绘制行为仿真图
figure(2)
% subplot(2,1,1)
% for i=1:N
%     plot(0:T-1,A(i,:),'-o');
%     hold on 
% end
% title('情形2：Action变化曲线')

% C =del2(A);
% mesh(A,C,'FaceLighting','gouraud','LineWidth',0.3);
% title('情形2：Action变化曲线')
%绘制Action响应曲线

%bar3绘制
bar3(A)
xlim([0 T+1]);
ylim([0 N+1]);
title({['agent数:' num2str(N) ' 迭代次数:' num2str(T)];
    ['左区间:' num2str(epsilo_L) ' 右区间:' num2str(epsilo_R)];
    ['行为响应值:' num2str(epsilo_Act)]})

figure(3)
% subplot(2,1,2)
plot(0:T-1,frequency_Action,0:T-1,1-frequency_Action);
ylim([0 1]);
legend('Action=1','Action=0')
title({['agent数:' num2str(N) ' 迭代次数:' num2str(T)];
    ['左区间:' num2str(epsilo_L) ' 右区间:' num2str(epsilo_R)];
    ['行为响应值:' num2str(epsilo_Act)]})
end
