%用于生成矩阵元素全为一个相同数的矩阵
%传入参数为矩阵行数、列数、元素的值
function minusOneM=genArbitraryMatrix(row,col,number)
M=zeros(row,col);
for i=1:row
    for j=1:col
        M(i,j)=number;
    end
end
minusOneM=M;
end