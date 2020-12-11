clear
N=10;
X0=0:1/(N-1):1; %uniform initial opinion profile
lamda=[5 3;4 6];
Temp=[X0' 1-X0'];
R=Temp*lamda';
A=zeros(N,1)
for k=1:N
    A(k,1)=find(R(k,:)==min(R(k,:)))-1
end
