%�����޷�������Ϊѡ��ĸ��壬���д����ж�
%�������Ϊ��ǰ�۵㣬�۵��ڽ�������Ϊ
%��Ϊ����ʱѡ�����
function neighborAction=obNeighborA2(X,neighborM,a,b)
N=length(X);
Action=zeros(N,1);
Action(X<a,1)=-1;
Action(X>=b,1)=1;
for i=1:N
    cntA1=sum(Action(neighborM(i,:)==1,1)==1);%����۵�����������Ϊѡ�����
    cntAN1=sum(Action(neighborM(i,:)==1,1)==-1);
    if Action(i)==0%�������޷������Լ�����Ϊѡ��ʱ
        if cntA1>cntAN1%if7
            Action(i,1)=1;
        else
            if cntA1<cntAN1%if6
                Action(i,1)=-1;
            else
                if cntA1==cntAN1 && X(i)>=0.5%if5%�����ѭ�����ڵõ�����Ĺ۵�ֵ���ڲ�ȷ���������Ϊ
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
