%定义阈值触发行为函数
%传入参数分别为当前时刻观点，当前时刻的邻近矩阵，偏好于Action=0的程度以及偏好于Action=1的程度
%假定对于区间在[A0,A1]的个体，其选择为邻近集中的行为比例较高者
function A_new=TTA(X_new,neighborM,a,b)
num=length(X_new);
A=genArbitraryMatrix(num,1,-1);
A(X_new>b)=1;
A(X_new<a)=0;
%方案2：未确定行为的个体，只会参考邻近集中满足[0,a)和[b,1)的个体的行为
for i=1:num
    if A(i)==-1 
        cnt0=sum(X_new(neighborM(i,:)==1)<a);
        cnt1=sum(X_new(neighborM(i,:)==1)>b);
        if cnt0==cnt1
            %对于0.5的个体随机选择
            if X_new(i)==0.5
                A(i)=randi([0,1]);
            else
                A(i)=(X_new(i)>0.5);
            end
%             %对于[0.5,1]的都选择1
%             A(i)=(X_new(i)>=0.5);
        else
            A(i)=max(cnt0,cnt1)==cnt1;
        end
    end
end
A_new=A;       
end