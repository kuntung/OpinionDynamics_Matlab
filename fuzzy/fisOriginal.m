%得到一个fis的对象
clear;
fis=readfis('tipper');
showrule(fis)%默认的语义规则
showrule(fis,'Format','symbolic')%通过逻辑符号显示规则
showrule(fis,'Format','indexed')%显示规则矩阵
showfis(fis)%显示推理系统的详细信息
% plotfis(fis)
%添加一条新的规则
%IF food is not rancid THEN tip is average
newRule=[0 -1 2 1 0];
fis=addrule(fis,newRule);
showfis(fis)
showrule(fis)%默认的语义规则
showrule(fis,'Format','symbolic')%通过逻辑符号显示规则
showrule(fis,'Format','indexed')%显示规则矩阵
%显示隶属度函数
plotmf(fis,'input',1)
plotmf(fis,'input',2)
plotmf(fis,'output',1)
%移除输入1的语义变量'excellent'的隶属度函数
fis=rmmf(fis,'input',1,'mf',3);
plotmf(fis,'input',1)
fis=addmf(fis,'input',1,'excellent','trimf',[0,8,10]);%将原来删除的隶属度函数更改为高斯隶属度函数
plotmf(fis,'input',1)
%添加一个新的输入：心情,心情语义变量为sad，good，happy
%可以考虑添加一个新的输出：投诉与否，是否推荐该餐厅~
fis=addvar(fis,'input','mood',[0 10]);
fis=addmf(fis,'input',3,'sad','gaussmf',[1.5 0]);
fis=addmf(fis,'input',3,'good','gaussmf',[1.5 5]);
fis=addmf(fis,'input',3,'happy','gaussmf',[1.5 10]);
showfis(fis)
%更新新的规则
% RULE1:IF food is delicious or service is excellent THEN tip is average
% RULE2:IF food is rancid or service is poor THEN tip is cheap
% RULE3:IF food is not rancid and service is not bad and mood is not sad THEN tip is  average
% RULE4:IF mood is happy and food is delicious THEN tip is generous
fis.rule=[];%清空原来的rule
ruleMatrix=[3 2 0, 2, 1, 2;1 1 0,1, 1, 2;-1 -1 -1, 2,1, 1;0 2 3,3,1,1];
fis=addrule(fis,ruleMatrix);
showfis(fis)
showrule(fis)%默认的语义规则
plotfis(fis)
%%计算输入后的结果
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