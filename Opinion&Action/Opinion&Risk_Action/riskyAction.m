%风险型决策
function A_temp=riskyAction(Xi,risk_table)
temp=[Xi, 1-Xi];
N=length(Xi);
A_temp=zeros(N,1);
R=temp*risk_table';
    for k=1:length(Xi)
        ind=find(R(k,:)==min(R(k,:)));
        if ind(1)==1
%         if ind==1 %报错的时候
            A_temp(k)=1;
        else
            A_temp(k)=0;
        end
    end

end