%��������ֱ�Ϊ��ʼ�۵㼯��ƫ����Action=0�ĳ̶��Լ�ƫ����Action=1�ĳ̶�
%p��ʾ����ԥ�����ڵĸ����������ѡ����Ϊ
function A_init=PTA(X0,A0,A1,p)
num=size(X0,1);
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