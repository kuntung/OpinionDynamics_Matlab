%输入格式为WeightChange_HK(agent数，迭代时间，信域半径,权重分段点,权重a,权重b)
%考虑所有agent的观点
%aij=1/cnt or 0 or 1-sum(aij)
%分段点取[0,1]之间小数
%φ(r)=aχ[0,ε/k]+bχ[ε/k,ε]
function test=WeightChange_HK(N,T,epsilon,k,a,b)
% X0=rand(N,1);%初始观点为[0,1]之间的随机值
X0=0:1/(N-1):1; %uniform initial opinion profile
%得到epsilonLmin 以及epsilonLmax
epsilonmin=epsilon*k;
epsilonmax=epsilon;
X=zeros(N,T);
X(:,1)=X0;
for j=2:T
    W=eye(N);
    for i=1:N
        dis=ones(1,N);%初始化观点差值
        w=zeros(1,N);%初始化行权重ai·
        for k=1:N
            dis(k)=abs(X(i,j-1)-X(k,j-1));
            if dis(k)>=0 && dis(k)<=epsilonmin
                w(k)=a;
            else
                if dis(k)<=epsilonmax && dis(k)>=epsilonRmin
                    w(k)=b;
                end
            end%权重分子运算结束
        end
        %得到当前迭代权重行向量
        for t=1:N
            W(i,t)=w(t)/sum(w);
        end
    end
    X(:,j)=W*X(:,j-1);
end
test=W;
for t=1:N
    plot(0:T-1,X(t,:),'Color',[X0(t),abs(0.7-X0(t)),abs(0.4-X0(t))]);
    hold on;
end
title('Uniform initial opinion profile-mechanism 1');
end
