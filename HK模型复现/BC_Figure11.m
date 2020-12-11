function BC_Figure11(N,T,ratio)
X=zeros(N,T); %opinion profile
X0=rand(N,1); %random initial opinion profile
X(:,1)=X0;
Z=zeros(100,40);
%更新迭代观点
for e=1:40
    epsilo_R=e/100;
    epsilo_L=ratio*epsilo_R;
    X=zeros(N,T); %opinion profile
    X(:,1)=X0;
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

end
figure(1)
C =del2(Z);
mesh(Z,C,'FaceLighting','gouraud','LineWidth',0.3);
hold on;
figure(2)
delta=diff(X');
% subplot(2,1,2);
plot(0:1:T-2,delta);
%shading interp
end
for i=1:5
plot(P(i,:),Q(i,:));
hold on;
end