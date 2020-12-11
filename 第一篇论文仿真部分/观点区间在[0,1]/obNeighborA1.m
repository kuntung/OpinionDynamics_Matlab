%对于无法做出行为选择的个体，进行随机选择
%传入参数为当前观点，观点邻近矩阵，行为，触发阈值
function neighborAction=obNeighborA1(X,neighborM,a,b)
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
                %不确定行为机制1
                if cntA1==cntAN1%当行为不确定时，随机选择
                    temp=randi([0,1]);
                     if temp==0%if2
                         Action(i,1)=-1;
                     else
                         if temp==1%if1
                                Action(i,1)=1;
                         end%end1
                     end
                end
            end%end6
        end%end7
    end%end8
end
neighborAction=Action;                      
end
