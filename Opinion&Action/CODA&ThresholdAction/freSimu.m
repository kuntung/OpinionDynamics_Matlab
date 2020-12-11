function freSimu(N,T,a,b,step)
%更新迭代观点
for e=1:step
    epsilo_R=e/100;
    epsilo_L=e/100;
    X=zeros(N,T); %opinion profile
    X0=0:1/(N-1):1; %uniform initial opinion profile
    % X0=rand(N,1); %random initial opinion profile
    A=zeros(N,T);%生成行为矩阵
    X(:,1)=X0;
    A(:,1)=(X0>=0.5);%风险型决策初始化
    frequency_Action=zeros(1,T);%初始化频率为0
    frequency_Action(1,1)=sum(A(:,1))/N;
    Z=zeros(100,step);
    for i=2:T
        for j=1:N
            acc=0;
            cnt=0;
            for k=1:N
                dis=X(k,i-1)-X(j,i-1);
                if (dis<=epsilo_R) && (dis>=-epsilo_L)
                    if k~=j
                    temp_P=coda_rule(X(j,i-1),X(j,1:i-1),A(j,1:i-1));%传入当前个体j的历史观点和历史行为
                    acc=temp_P+acc;
                    cnt=cnt+1;
                    end
                end
            end
            X(j,i)=acc/cnt;
        end
        A(:,i)=TTA(X(:,i-1),A(:,i-1),a,b);%采用阈值触发行为机制
        frequency_Action(1,i)=sum(A(:,i))/N;%计算当前行为比例
    end
    for op=1:100
        Z(op,e)=length(find(roundn(X(:,T),-2)==op/100))/N;
    end
    X=zeros(N,T); %opinion profile
    X(:,1)=X0;
end
C = del2(Z);
mesh(Z,C);
hold on;

%shading interp
end
