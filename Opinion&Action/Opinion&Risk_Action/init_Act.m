%������Ϊ��ʼ������
%��������ֱ�Ϊ��ʼ�۵㼯��ƫ����Action=0�ĳ̶��Լ�ƫ����Action=1�ĳ̶�
%�ٶ�����������[A0,A1]�ĸ��壬��ѡ��Action=1�ĸ��ʵ�����۵�ֵ
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