%�����޷�������Ϊѡ��ĸ��壬���д����ж�
%�������Ϊ��ǰ�۵㣬�۵��ڽ�������Ϊ
function neighborAction=obNeighborA(X,neighborM,Action)
N=length(X);
for i=1:N

%     cntA1=sum(Action(neighborM(i,:)==1)==1);
%     cntAN1=sum(Action(neighborM(i,:)==1)==-1);
    cntA1=sum(Action(neighborM(i,:)==1)==1);%����۵�����������Ϊѡ�����
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
