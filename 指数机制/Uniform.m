function X_new=Uniform(X)
[m,n]=size(X);
for k=1:n
    X(:,k)=sort(X(:,k));
for i=1:n
    for j=1:m
        X(j,i)=X(j,i)/X(m,i);
    end
end
X_new=X;
end