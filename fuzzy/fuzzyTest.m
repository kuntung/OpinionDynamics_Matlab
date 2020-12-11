%����һ����Ʒ������Ը����ϵͳ
%����1��������Ը[0 10]��ΪAttitude
%����������� �� ǿ ��ǿ
%����2����Ʒ����[0 10]��ΪComment
%����������� �� �� ����
%���1��������ΪAction=���� Action=��
%���ʵ�ʣ��򵥵Ķ����ĸ�����
%rule1: IF ������Ը��ǿ THEN ACtion=��
%rule2: IF ��Ʒ���ۼ����ҹ�����ԸΪ��Ϊ�� THEN Action=��
%rule3: IF ��Ʒ����Ϊ�� THEN Action=����
%rule4: IF �����Ʒ���۲�Ϊ���ҹ�����Ըǿ THEN Action=��
%%%�ĸ�������߼���ʾ��ʽ
%rule1: if Attitude==very strong -> Action=��
%rule2: if comment==very good && attitude~=weak -> Action=��
%rule3: if comment==bad -> Action=����
%rule4: if comment~=bad && attitude==strong -> Action=��
clear;
close all;
shopper = newfis('shopper');
%���ϵͳ��������
shopper=addvar(shopper,'input','Attitude',[0 10]);
shopper=addvar(shopper,'input','Comment',[0 10]);
shopper=addvar(shopper,'output','Action',[0 1]);
%���ϵͳ�����������������������Ⱥ���
figure
shopper=addmf(shopper,'input',1,'weak','gaussmf',[1 0]);
shopper=addmf(shopper,'input',1,'medium','gaussmf',[1 3.33]);
shopper=addmf(shopper,'input',1,'strong','gaussmf',[1 6.77]);
shopper=addmf(shopper,'input',1,'very strong','gaussmf',[1 10]);
plotmf(shopper,'input',1)
title('���ڹ�����Ը�������Ⱥ���')
showfis(shopper);
figure
shopper=addmf(shopper,'input',2,'bad','trimf',[0 0 3.33]);
shopper=addmf(shopper,'input',2,'medium','trimf',[0 3.33 6.67]);
shopper=addmf(shopper,'input',2,'good','trimf',[3.33 6.67 10]);
shopper=addmf(shopper,'input',2,'very good','trimf',[6.67 10 10]);
plotmf(shopper,'input',2)
title('������Ʒ���۵������Ⱥ���')
figure
shopper=addmf(shopper,'output',1,'����','zmf',[0.5 0.5]);
shopper=addmf(shopper,'output',1,'��','smf',[0.5 0.5]);
plotmf(shopper,'output',1)
title('���ڹ������������Ⱥ���')
ruleMatrix=[4 0 2 1 1;-1 4 2 1 1;0 1 1 1 1;3 -1 2 1 1];
shopper=addrule(shopper,ruleMatrix);
showrule(shopper,'Format','symbolic');
figure
plotfis(shopper);
%�����������[7 8]
[output,fuzzifiedInputs,ruleOutputs,aggregatedOutput] = evalfis([7 8],shopper);
outputRange = linspace(shopper.output.range(1),shopper.output.range(2),length(aggregatedOutput))'; 
figure
subplot(211)
plot(outputRange,ruleOutputs,[output output],[0 1])
title('ÿ����������')
legend('rule1','rule2','rule3','rule3')
xlabel('Action')
ylabel('Output Membership')
subplot(212)
plot(outputRange,aggregatedOutput,[output output],[0 1])
xlabel('Action')
ylabel('Output Membership')
legend('Aggregated output fuzzy set','Defuzzified output')
title('�������')
figure
ruleview(shopper)
% for i=1:4
%     hold on;
%     plot([fuzzifiedInputs(i),fuzzifiedInputs(i)],[0 1]);
% end

%���¹����
%%%�ĸ�������߼���ʾ��ʽ
%rule1: if Attitude==very strong -> Action=��
%rule2: if comment==very good && attitude==strong -> Action=��
%rule3: if comment==bad -> Action=����
%rule4: if comment==good && attitude==strong -> Action=��
shopper.rule=[];
ruleMatrix=[4 0 2 1 1;3 4 2 1 1;0 1 1 1 1;3 3 2 1 1];
shopper=addrule(shopper,ruleMatrix);
showrule(shopper,'Format','symbolic');
figure
plotfis(shopper);
%�����������[7 8]
[output,fuzzifiedInputs,ruleOutputs,aggregatedOutput] = evalfis([2 4],shopper);
outputRange = linspace(shopper.output.range(1),shopper.output.range(2),length(aggregatedOutput))'; 
figure
subplot(211)
plot(outputRange,ruleOutputs,[output output],[0 1])
title('ÿ����������')
legend('rule1','rule2','rule3','rule3')
xlabel('Action')
ylabel('Output Membership')
subplot(212)
plot(outputRange,aggregatedOutput,[output output],[0 1])
xlabel('Action')
ylabel('Output Membership')
legend('Aggregated output fuzzy set','Defuzzified output')
title('�������')
figure
ruleview(shopper)