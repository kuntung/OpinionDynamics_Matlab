%生成一个商品购买意愿测试系统
%输入1：购买意愿[0 10]记为Attitude
%语义变量：弱 中 强 很强
%输入2：商品评价[0 10]记为Comment
%语义变量：差 中 好 极好
%输出1：购买行为Action=不买， Action=买
%结合实际，简单的定义四个规则
%rule1: IF 购买意愿很强 THEN ACtion=买
%rule2: IF 商品评价极好且购买意愿为不为弱 THEN Action=买
%rule3: IF 商品评价为差 THEN Action=不买
%rule4: IF 如果商品评价不为差且购买意愿强 THEN Action=买
%%%四个规则的逻辑表示形式
%rule1: if Attitude==very strong -> Action=买
%rule2: if comment==very good && attitude~=weak -> Action=买
%rule3: if comment==bad -> Action=不买
%rule4: if comment~=bad && attitude==strong -> Action=买
clear;
close all;
shopper = newfis('shopper');
%添加系统输入和输出
shopper=addvar(shopper,'input','Attitude',[0 10]);
shopper=addvar(shopper,'input','Comment',[0 10]);
shopper=addvar(shopper,'output','Action',[0 1]);
%添加系统输入输出的语义变量及隶属度函数
figure
shopper=addmf(shopper,'input',1,'weak','gaussmf',[1 0]);
shopper=addmf(shopper,'input',1,'medium','gaussmf',[1 3.33]);
shopper=addmf(shopper,'input',1,'strong','gaussmf',[1 6.77]);
shopper=addmf(shopper,'input',1,'very strong','gaussmf',[1 10]);
plotmf(shopper,'input',1)
title('关于购买意愿的隶属度函数')
showfis(shopper);
figure
shopper=addmf(shopper,'input',2,'bad','trimf',[0 0 3.33]);
shopper=addmf(shopper,'input',2,'medium','trimf',[0 3.33 6.67]);
shopper=addmf(shopper,'input',2,'good','trimf',[3.33 6.67 10]);
shopper=addmf(shopper,'input',2,'very good','trimf',[6.67 10 10]);
plotmf(shopper,'input',2)
title('关于商品评价的隶属度函数')
figure
shopper=addmf(shopper,'output',1,'不买','zmf',[0.5 0.5]);
shopper=addmf(shopper,'output',1,'买','smf',[0.5 0.5]);
plotmf(shopper,'output',1)
title('关于购买结果的隶属度函数')
ruleMatrix=[4 0 2 1 1;-1 4 2 1 1;0 1 1 1 1;3 -1 2 1 1];
shopper=addrule(shopper,ruleMatrix);
showrule(shopper,'Format','symbolic');
figure
plotfis(shopper);
%进行输入测试[7 8]
[output,fuzzifiedInputs,ruleOutputs,aggregatedOutput] = evalfis([7 8],shopper);
outputRange = linspace(shopper.output.range(1),shopper.output.range(2),length(aggregatedOutput))'; 
figure
subplot(211)
plot(outputRange,ruleOutputs,[output output],[0 1])
title('每个规则的输出')
legend('rule1','rule2','rule3','rule3')
xlabel('Action')
ylabel('Output Membership')
subplot(212)
plot(outputRange,aggregatedOutput,[output output],[0 1])
xlabel('Action')
ylabel('Output Membership')
legend('Aggregated output fuzzy set','Defuzzified output')
title('最终输出')
figure
ruleview(shopper)
% for i=1:4
%     hold on;
%     plot([fuzzifiedInputs(i),fuzzifiedInputs(i)],[0 1]);
% end

%更新规则后
%%%四个规则的逻辑表示形式
%rule1: if Attitude==very strong -> Action=买
%rule2: if comment==very good && attitude==strong -> Action=买
%rule3: if comment==bad -> Action=不买
%rule4: if comment==good && attitude==strong -> Action=买
shopper.rule=[];
ruleMatrix=[4 0 2 1 1;3 4 2 1 1;0 1 1 1 1;3 3 2 1 1];
shopper=addrule(shopper,ruleMatrix);
showrule(shopper,'Format','symbolic');
figure
plotfis(shopper);
%进行输入测试[7 8]
[output,fuzzifiedInputs,ruleOutputs,aggregatedOutput] = evalfis([2 4],shopper);
outputRange = linspace(shopper.output.range(1),shopper.output.range(2),length(aggregatedOutput))'; 
figure
subplot(211)
plot(outputRange,ruleOutputs,[output output],[0 1])
title('每个规则的输出')
legend('rule1','rule2','rule3','rule3')
xlabel('Action')
ylabel('Output Membership')
subplot(212)
plot(outputRange,aggregatedOutput,[output output],[0 1])
xlabel('Action')
ylabel('Output Membership')
legend('Aggregated output fuzzy set','Defuzzified output')
title('最终输出')
figure
ruleview(shopper)