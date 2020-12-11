%�õ�һ��fis�Ķ���
clear;
fis=readfis('tipper');
showrule(fis)%Ĭ�ϵ��������
showrule(fis,'Format','symbolic')%ͨ���߼�������ʾ����
showrule(fis,'Format','indexed')%��ʾ�������
showfis(fis)%��ʾ����ϵͳ����ϸ��Ϣ
% plotfis(fis)
%���һ���µĹ���
%IF food is not rancid THEN tip is average
newRule=[0 -1 2 1 0];
fis=addrule(fis,newRule);
showfis(fis)
showrule(fis)%Ĭ�ϵ��������
showrule(fis,'Format','symbolic')%ͨ���߼�������ʾ����
showrule(fis,'Format','indexed')%��ʾ�������
%��ʾ�����Ⱥ���
plotmf(fis,'input',1)
plotmf(fis,'input',2)
plotmf(fis,'output',1)
%�Ƴ�����1���������'excellent'�������Ⱥ���
fis=rmmf(fis,'input',1,'mf',3);
plotmf(fis,'input',1)
fis=addmf(fis,'input',1,'excellent','trimf',[0,8,10]);%��ԭ��ɾ���������Ⱥ�������Ϊ��˹�����Ⱥ���
plotmf(fis,'input',1)
%���һ���µ����룺����,�����������Ϊsad��good��happy
%���Կ������һ���µ������Ͷ������Ƿ��Ƽ��ò���~
fis=addvar(fis,'input','mood',[0 10]);
fis=addmf(fis,'input',3,'sad','gaussmf',[1.5 0]);
fis=addmf(fis,'input',3,'good','gaussmf',[1.5 5]);
fis=addmf(fis,'input',3,'happy','gaussmf',[1.5 10]);
showfis(fis)
%�����µĹ���
% RULE1:IF food is delicious or service is excellent THEN tip is average
% RULE2:IF food is rancid or service is poor THEN tip is cheap
% RULE3:IF food is not rancid and service is not bad and mood is not sad THEN tip is  average
% RULE4:IF mood is happy and food is delicious THEN tip is generous
fis.rule=[];%���ԭ����rule
ruleMatrix=[3 2 0, 2, 1, 2;1 1 0,1, 1, 2;-1 -1 -1, 2,1, 1;0 2 3,3,1,1];
fis=addrule(fis,ruleMatrix);
showfis(fis)
showrule(fis)%Ĭ�ϵ��������
plotfis(fis)
%%���������Ľ��
[output,fuzzifiedInputs,ruleOutputs,aggregatedOutput] = evalfis([2 8 4],fis);
outputRange = linspace(fis.output.range(1),fis.output.range(2),length(aggregatedOutput))'; 
plot(outputRange,aggregatedOutput,[output output],[0 1])
xlabel('Tip')
ylabel('Output Membership')
legend('Aggregated output fuzzy set','Defuzzified output')
figure()
subplot(211)
plot(outputRange,ruleOutputs)
legend('rule1','rule2','rule3','rule4')
subplot(212)
plot(outputRange,aggregatedOutput)%aggregatemethod is max
%or max
%and min
%not 1-weight