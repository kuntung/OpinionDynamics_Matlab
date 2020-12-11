%%%%opinion dynamic with reputation explanation
epsilon=0.4;
x1=0:0.01:epsilon/3;
y1=ones(1,size(x1,2));
x2=epsilon:0.01:1;
y2=zeros(1,size(x2,2));
x3=epsilon/3:0.01:2*epsilon/3;
y3=ones(1,size(x3,2));
x4=2*epsilon/3:0.01:epsilon;
y4=ones(1,size(x4,2));
%分开绘制各线段
plot(x1,y1,'b');
hold on;
plot(x2,y2,'b');
hold on;
plot(x3,y3);
hold on;
plot(x4,y4);
%连续线段绘制
% plot([x1 x3 x4 x2],[y1 y3 y4 y2])
axis([-0.05 1.05 -0.05 1.05]);
xlabel('The difference between any two agents');
ylabel('The corresponding weight value');