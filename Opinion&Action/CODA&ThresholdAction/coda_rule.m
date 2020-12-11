%����Ŀ��agentʵ��CODA�۵���»���
%ʵ�ֵ���Martin�����е�(2)
%�ڸ���۵�������
function [Pinew] = coda_rule( Pi,Aj,Xi_history,Ai_history,a,b)
% Dynamic CODA Rule
%�����ھ���ʷƫ��Acton=1ʱ��ѡ����
b=0.5;
a=0.5;
%���ǹ۵�ֵΪ0.5�����
pre1=sum(Xi_history>b)+0.5*sum(Xi_history==0.5);
pre0=sum(Xi_history<a)+0.5*sum(Xi_history==0.5);
if pre1>0
    A1P1=(sum(Ai_history(Xi_history>b)==1)+0.5*sum(Ai_history(Xi_history==0.5)==1))/pre1;%alpha
    A0P1=(sum(Ai_history(Xi_history>b)==0)+0.5*sum(Ai_history(Xi_history==0.5)==1))/pre1;%1-alpha
else
    A1P1=0;
    A0P1=0;
end
%�����ھ���ʷƫ��Acton=0ʱ��ѡ��
if pre0>0
    A0P0=(sum(Ai_history(Xi_history<a)==0)+0.5*sum(Ai_history(Xi_history==0.5)==0))/pre0;%belta
    A1P0=(sum(Ai_history(Xi_history<a)==1)+0.5*sum(Ai_history(Xi_history==0.5)==0))/pre0;%1-belta
else
    A0P0=0;
    A1P0=0;
end
% %�����ǹ۵�ֵΪ0.5�����
% pre1=sum(Xi_history>b);
% pre0=sum(Xi_history<a);
% if pre1>0
%     A1P1=sum(Ai_history(Xi_history>b)==1)/pre1;%alpha
%     A0P1=sum(Ai_history(Xi_history>b)==0)/pre1;%1-alpha
% else
%     A1P1=0;
%     A0P1=0;
% end
% %�����ھ���ʷƫ��Acton=0ʱ��ѡ��
% if pre0>0
%     A0P0=sum(Ai_history(Xi_history<a)==0)/pre0;%belta
%     A1P0=sum(Ai_history(Xi_history<a)==1)/pre0;%1-belta
% else
%     A0P0=0;
%     A1P0=0;
% end
%�жϴ���Ĺ۵�ƫ��
Flag=-1;
%���ھ���ΪΪAction=1ʱ���ñ��ʽ��ʶ��
if Aj==1
    if Pi==0
        Flag=0;
    else
        if Pi==1
            Flag=1;     
        else
            Flag=2;
        end
    end
    if A1P0==0
        Flag=1;
    end
    if A1P1==0
        Flag=0;
    end
else%���ھ���ΪΪAction=0ʱ���ñ��ʽ��ʶ��
    %O2=Pb/(1-Pb)*A0P0/A0P1
   if Pi==1
        Flag=1;
    else
        if Pi==0
            Flag=0;     
        else
            Flag=3;
        end
    end
    if A0P0==0
        Flag=1;
    end
    if A0P1==0
        Flag=0;
    end
end
    
%���µõ���ǰʱ�̸���i�Ĺ۵�ֵ
switch Flag
    case 0
        Pinew=0;
    case 1
        Pinew=1;
    case 2
        O1=A1P1/A1P0*Pi/(1-Pi);
        Pinew=O1/(1+O1);
    case 3
        O2=A0P1/A0P0*Pi/(1-Pi);
        Pinew=O2/(1+O2);
    otherwise
        disp('The opinion domain is wrong');
end
end
