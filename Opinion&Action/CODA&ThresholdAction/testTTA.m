%testTTA
N=10;
epsilo_L=0.2;
epsilo_R=0.2;
a=0.3;b=0.7;
X_new=0:1/(N-1):1; %uniform initial opinion profile
NM=isNeighbor(X0,epsilo_L,epsilo_R);
A(X_new>=b)=1
A(X_new<a)=0
for i=1:N
    if A(i)==-1 
        cnt0=sum(X_new(NM(i,:)==1)<a)
        cnt1=sum(X_new(NM(i,:)==1)>=b)
        if cnt0==cnt1
            A(i)=(X_new(i)>=0.5)
        else
            A(i)=max(cnt0,cnt1)==cnt1
        end
    end
end
A2=TTA(X_new,NM,a,b)