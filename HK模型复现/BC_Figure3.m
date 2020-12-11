function BC_Figure3(N,T)
X=zeros(N,T); %opinion profile
X0=rand(N,1); %random initial opinion profile
X(:,1)=X0;
Z=zeros(100,40);
%更新迭代观点
for e=1:40
    epsilo_R=e/100;
    epsilo_L=e/100;
    for i=2:T
        for j=1:N
            sum=0;
            cnt=0;
            for k=1:N
                dis=X(k,i-1)-X(j,i-1);
                if (dis<=epsilo_R) && (dis>=-epsilo_L)
                    sum=X(k,i-1)+sum;
                    cnt=cnt+1;
                end
            end
            X(j,i)=sum/cnt;
        end
    end
    for op=1:100
        Z(op,e)=length(find(roundn(X(:,T),-2)==op/100))/N;
    end
    X=zeros(N,T); %opinion profile
    X(:,1)=X0;
end
C = del2(Z);
mesh(Z,C);
hold on;

%shading interp
end
