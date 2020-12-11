%S state substitute by 0,I ---1  R--0
function result=NPO_Diffusion(N,T,lambda,v,gama)
X=zeros(N,T);
stateNum=zeros(3,T-1);%生成不同时刻各状态的数量
for t=1:N
    X(t,1)=randi(3)-1;%得到初始值
end
for i=2:T
    stateS=sum(X(:,i-1)==0);
    stateI=sum(X(:,i-1)==1);
    stateR=sum(X(:,i-1)==2);
    pS2I=lambda*stateI/N;
    stateNum(:,i-1)=[stateS stateI stateR];
%     pS2S=1-pS2I;%得到S状态次态转换概率
    pI2R=gama*stateI/N;
%     pI2I=1-pI2R;
    for j=1:N
       %生成一个随机数用来确定次态转变形式
        temp=rand();
        %当当前状态为S时
        if X(j,i-1)==0
            if temp<=pS2I
                X(j,i)=1;
            else
                X(j,i)=0;
            end
        end
        %当前状态为I时
        if X(j,i-1)==1
            if temp<=pI2R
                X(j,i)=2;
            else
                X(j,i)=1;
            end
        end
        %当前状态为R时
        if X(j,i-1)==2
            X(j,i)=2;
        end
    end
end
plot(stateNum(1,:),'r-*');
hold on;
plot(stateNum(2,:),'g-x');
hold on;
plot(stateNum(3,:),'b-o');
hold on;

legend('s','i','r');
result=stateNum;
end