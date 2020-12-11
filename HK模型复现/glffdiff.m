function dy=glffdiff(y,k,gam)
if strcmp(class(y),'function_handle'),y=y(N,k);end
h=0.1;w=1;
% y=y(:);k=k(:);
for j=2:length(k),w(j)=w(j-1)*(1-(gam+1)/(j-1));end
for i=1:length(k),dy(i)=w(1:i)*[y(i:-1:1)]/h^gam;end