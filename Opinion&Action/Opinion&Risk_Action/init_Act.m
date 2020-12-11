%定义行为初始化函数
%传入参数分别为初始观点集，偏好于Action=0的程度以及偏好于Action=1的程度
%假定对于区间在[A0,A1]的个体，其选择Action=1的概率等于其观点值
function A_init=init_Act(X0,A0,A1)
num=size(X0,2);
A=zeros(num,1);
for i=1:num
    if X0(i)<=A0
        A(i)=0;
    end
    if X0(i)>=A1
        A(i)=1;
    end
    if X0(i)>=A0&&X0(i)<=A1
        if rand<=X0(i)
            A(i)=1;
        else
            A(i)=0;
        end
    end
end
A_init=A;       
end