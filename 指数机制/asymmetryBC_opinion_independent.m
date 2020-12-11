%用于绘制非对称区间（opinion independent）的示意图
epsilonL=0.3;
epsilonR=1-epsilonL;
x1=-1:0.01:-epsilonL;
x2=-epsilonL:0.01:epsilonR;
x3=epsilonR:0.01:1;
y1=zeros(1,size(x1,2));
y2=ones(1,size(x2,2));
y3=zeros(1,size(x3,2));
plot(x1,y1,'b');
hold on;
plot(x2,y2,'b');
hold on;
plot(x3,y3,'b');
axis([-1.05 1.05 -0.05 1.05]);
xlabel('The difference between any two agents')
ylabel('The corresponding weight value');