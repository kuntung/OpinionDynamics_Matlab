%�����޷�������Ϊѡ��ĸ��壬�������ѡ��
%�������Ϊ��ǰ�۵㣬�۵��ڽ�������Ϊ��������ֵ
function neighborAction=obNeighborA1(X,neighborM,a,b)
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
                %��ȷ����Ϊ����1
                if cntA1==cntAN1%����Ϊ��ȷ��ʱ�����ѡ��
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
