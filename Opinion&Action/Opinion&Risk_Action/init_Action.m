%定义行为初始化函数
%传入参数分别为初始观点集，偏好于Action=0的程度以及偏好于Action=1的程度
%p表示在犹豫区间内有多少人采取了相同的观点
function A_init=init_Action(X0,A0,A1,p)
num=size(X0,2);
A=zeros(num,1);
for i=1:num
    if X0(i)<=A0
        A(i)=0;
    end
    if X0(i)>=A1
        A(i)=1;
    end
    if X0(i)>A0&&X0(i)<0.5
        if rand<=p
            A(i)=0;
        else
            A(i)=1;
        end
    end
    if X0(i)<A1&&X0(i)>=0.5
        if rand<=p
            A(i)=1;
        else
            A(i)=0;
        end
    end
end
A_init=A;
        
end