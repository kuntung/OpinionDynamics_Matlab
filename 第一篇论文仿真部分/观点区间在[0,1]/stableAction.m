%���ڸ�����Ϊ���ᷢ���ı�����
function resultAction=stableAction(X,ONM,a,b)
N=size(X,1);
T=size(X,2);
resultAction=zeros(N,T);
%��ʼ��Ϊ
resultAction(X(:,1)>b,1)=1;
resultAction(X(:,1)<a,1)=-1;
%ʱ��2��T����Ϊ����Ϊ����һ����
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