%�������ɾ���Ԫ��ȫΪһ����ͬ���ľ���
%�������Ϊ����������������Ԫ�ص�ֵ
function minusOneM=genArbitraryMatrix(row,col,number)
M=zeros(row,col);
for i=1:row
    for j=1:col
        M(i,j)=number;
    end
end
minusOneM=M;
end