%用于个体行为不会发生改变情形
function resultAction=stableAction(X,ONM,a,b)
N=size(X,1);
T=size(X,2);
resultAction=zeros(N,T);
%初始行为
resultAction(X(:,1)>b,1)=1;
resultAction(X(:,1)<a,1)=-1;
%时刻2到T的行为，行为具有一致性
for i=2:T
    for j=1:N
        if resultAction(j,i-1)==1
            resultAction(j,i)=1;
        elseif resultAction(j,i-1)==-1
            resultAction(j,i)=-1;
        elseif X(j,i)>b
            resultAction(j,i)=1;
        elseif X(j,i)<a
            resultAction(j,i)=-1;
        else
            resultAction(j,i)=0;
        end
    end
end
resultAction(:,T)=obNeighborA(X(:,T),ONM,resultAction(:,T));
end