%����Ŀ��agentʵ��CODA�۵���»���
%ʵ�ֵ���Martin�����е�(2)����alpha��beltaΪ�̶���ֵ
function [Pinew] = coda_rule_const( Pi,Action,alpha,belta)
% Dynamic CODA Rule
Flag=-1;
if Action==1
    Flag=1;
else
    if Action==-1
        Flag=2;
    end
end
if Pi==1 && Flag==1
    Flag=3;%�޷����ӵ�����
elseif Pi==0&&Flag==2
    Flag=4;%�޷���С������
end

switch Flag
    case 1
        O1=Pi/(1-Pi)*alpha/(1-belta);
        Pinew=O1/(1+O1);
    case 2
        O2=Pi/(1-Pi)*(1-alpha)/belta;
        Pinew=O2/(1+O2);
    case 3
        Pinew=1;
    case 4
        Pinew=0;
end
            
end
