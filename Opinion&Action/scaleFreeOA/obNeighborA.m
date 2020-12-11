%对于无法做出行为选择的个体，进行从众判定
%传入参数为当前观点，观点邻近矩阵，行为
function neighborAction=obNeighborA(X,neighborM,Action)
N=length(X);
for i=1:N

%     cntA1=sum(Action(neighborM(i,:)==1)==1);
%     cntAN1=sum(Action(neighborM(i,:)==1)==-1);
    cntA1=sum(Action(neighborM(i,:)==1)==1);%计算观点相近个体的行为选择比例
    cntAN1=sum(Action(neighborM(i,:)==1)==-1);
    if Action(i)==0
        if cntA1>cntAN1
            Action(i)=1;
        else
            if cntA1<cntAN1
                Action(i)=-1;
            else
                if cntA1==cntAN1 && X(i)>0.5
                    Action(i)=1;
                else
                    if cntA1==cntAN1 && X(i)<0.5
                        Action(i)=-1;
                    else
                        if cntA1==cntAN1 && X(i)==0.5
                            Action(i)=randi([4 5]);
                            if Action(i)==4
                                Action(i)=-1;
                            else
                                if Action(i)==5
                                    Action(i)=1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
%             if Action(i)==0
%                 Action(i)=-1;
%             end
end
neighborAction=Action;                      
end
