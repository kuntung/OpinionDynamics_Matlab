%������ֵ������Ϊ����
%��������ֱ�Ϊ��ǰʱ�̹۵㣬��ǰʱ�̵��ڽ�����ƫ����Action=0�ĳ̶��Լ�ƫ����Action=1�ĳ̶�
%�ٶ�����������[A0,A1]�ĸ��壬��ѡ��Ϊ�ڽ����е���Ϊ�����ϸ���
function A_new=TTA(X_new,neighborM,a,b)
num=length(X_new);
A=genArbitraryMatrix(num,1,-1);
A(X_new>b)=1;
A(X_new<a)=0;
%����2��δȷ����Ϊ�ĸ��壬ֻ��ο��ڽ���������[0,a)��[b,1)�ĸ������Ϊ
for i=1:num
    if A(i)==-1 
        cnt0=sum(X_new(neighborM(i,:)==1)<a);
        cnt1=sum(X_new(neighborM(i,:)==1)>b);
        if cnt0==cnt1
            %����0.5�ĸ������ѡ��
            if X_new(i)==0.5
                A(i)=randi([0,1]);
            else
                A(i)=(X_new(i)>0.5);
            end
%             %����[0.5,1]�Ķ�ѡ��1
%             A(i)=(X_new(i)>=0.5);
        else
            A(i)=max(cnt0,cnt1)==cnt1;
        end
    end
end
A_new=A;       
end