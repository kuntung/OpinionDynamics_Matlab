%���ڵõ��ޱ�������£�ÿ������Ĺ۵��ڽ�����
%��������ĸ�ʽΪ����ǰ�۵�ֵ���ޱ�������ڽӾ�����������
function neighborM=isOPM(X,scaleMatrix,epsilo_L,epsilo_R)
eps=1e-16;
N=length(X);
neighborM=genArbitraryMatrix(N,N,-1);
%�õ���ǰ�ޱ�������µĹ۵��ڽ�����
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