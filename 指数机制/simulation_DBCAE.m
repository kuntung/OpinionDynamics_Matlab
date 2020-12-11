%输入格式为simulation_DBCAE(agent数，迭代时间，右边区间最小值，右边区间最大值，比例系数K)
%考虑所有agent的观点
%指数机制加double confidence level
%Asymmetric confidence level, epsilonL=k*epsilonR
%aij=1/cnt or 0 or 1-sum(aij)
function simulation_DBCAE(N,T,epsilonRmin,epsilonRmax,k)
% X0=rand(N,1);%初始观点为[0,1]之间的随机值
X0=0:1/(N-1):1; %uniform initial opinion profile
%得到epsilonLmin 以及epsilonLmax
epsilonLmin=epsilonRmin*k;
epsilonLmax=epsilonRmax*k;
X=zeros(N,T);
X(:,1)=X0;
for j=2:T
    W=eye(N);
    for i=1:N
        dis=ones(1,N);%初始化观点差值
        w=zeros(1,N);%初始化行权重ai·
        for k=1:N
            dis(k)=X(i,j-1)-X(k,j-1);
            if dis(k)>=-epsilonLmin && dis(k)<=epsilonRmin%依据两观点之间差值dif得到其权重分子
                w(k)=1;
            else
                if (dis(k)<=epsilonRmax && dis(k)>=epsilonRmin)|| (dis(k)>=-epsilonLmax &&dis(k)<=-epsilonLmin) 
                    w(k)=exp(-abs(dis(k)));
                end
            end%权重分子运算结束
        end
        %得到当前迭代权重行向量
        for t=1:N
            W(i,t)=w(t)/sum(w);
        end
        W(i,i)=1+W(i,i)-sum(W(i,:));
    end
    X(:,j)=W*X(:,j-1);
end
for t=1:N
    plot(0:T-1,X(t,:),'Color',[X0(t),abs(0.7-X0(t)),abs(0.4-X0(t))]);
    hold on;
end
title('Uniform initial opinion profile-mechanism 1');
end
