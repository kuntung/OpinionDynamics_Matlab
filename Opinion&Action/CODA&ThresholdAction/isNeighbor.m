function neighborM=isNeighbor(X,epsilo_L,epsilo_R)
eps=1e-16;
N=length(X);
neigh=genArbitraryMatrix(N,N,-1);
for j=1:N
    for k=1:N
        if k==j
            neigh(j,k)=0;
        else
            dis=X(k)-X(j);
            if (dis>=-epsilo_L-eps)&&(dis<=epsilo_R+eps) 
%             if (dis>=-epsilo_L)&&(dis<=epsilo_R) 
                neigh(j,k)=1;
            else
                neigh(j,k)=0;
            end
        end
    end
end
neighborM=neigh;%得到当前观点集合下的邻近矩阵
end