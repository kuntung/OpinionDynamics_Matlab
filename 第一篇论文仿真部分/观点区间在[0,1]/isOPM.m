%用于得到无标度网络下，每个个体的观点邻近矩阵
%传入参数的格式为：当前观点值，无标度网络邻接矩阵，信域区间
function neighborM=isOPM(X,scaleMatrix,epsilo_L,epsilo_R)
eps=1e-16;
N=length(X);
neighborM=genArbitraryMatrix(N,N,-1);
%得到当前无标度网络下的观点邻近矩阵
for j=1:N
    for k=1:N
        if scaleMatrix(j,k)==0
            neighborM(j,k)=0;
        else
            dis=X(k)-X(j);
            if (dis>=-epsilo_L-eps)&&(dis<=epsilo_R+eps) 
%             if (dis>=-epsilo_L)&&(dis<=epsilo_R) 
                neighborM(j,k)=1;
            else
                neighborM(j,k)=0;
            end
        end
    end
end
end