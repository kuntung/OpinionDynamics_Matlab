%对于无法做出行为选择的个体，进行从众判定
%传入参数为当前观点，观点邻近矩阵，行为
%行为不定时选择从众
function neighborAction=obNeighborA2(X,neighborM,a,b)
N=length(X);
Action=zeros(N,1);
Action(X<a,1)=-1;
Action(X>=b,1)=1;
for i=1:N
    cntA1=sum(Action(neighborM(i,:)==1,1)==1);%计算观点相近个体的行为选择比例
    cntAN1=sum(Action(neighborM(i,:)==1,1)==-1);
    if Action(i)==0%当个体无法做出自己的行为选择时
        if cntA1>cntAN1%if7
            Action(i,1)=1;
        else
            if cntA1<cntAN1%if6
                Action(i,1)=-1;
            else
                if cntA1==cntAN1 && X(i)>=0.5%if5%后面的循环用于得到个体的观点值处于不确定区间的行为
                    Action(i,1)=1;
                else
                    if cntA1==cntAN1 && X(i)<0.5%if4
                        Action(i,1)=-1;
                    else
                    end%end4
                end%end5
            end%end6
        end%end7
    end%end8
end
neighborAction=Action;                      
end
