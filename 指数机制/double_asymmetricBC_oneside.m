%%%第一部分，绘制epsilonL_min epsilonL_max左半部分,opinion independent BC
k=0.9;
epsilonLmax=0.7;epsilonLmin=0.4;
epsilonRmax=epsilonLmax*k;
epsilonRmin=epsilonLmin*k;
x1=-1:0.01:-epsilonLmax;
x2=-epsilonLmax:0.01:-epsilonLmin;
x3=-epsilonLmin:0.01:0;%%左半部分坐标划分完毕
y1=zeros(1,size(x1,2));
y2=exp(x2);
y3=ones(1,size(x3,2));
plot(-x1,y1,'-*r');
hold on;
plot(-x2,y2,'-*r');
hold on;
plot(-x3,y3,'-*r');
grid on;
%左半部分绘制完毕
x4=0:0.01:epsilonRmin;
x5=epsilonRmin:0.01:epsilonRmax;
x6=epsilonRmax:0.01:1;
y4=ones(1,size(x4,2));
y5=exp(-x5);
y6=zeros(1,size(x6,2));
plot(x4,y4,'-og');
hold on;
plot(x5,y5,'-og');
hold on;
plot(x6,y6,'-og');
xlabel('Difference of any two agents')
ylabel('The corresponding weight')
axis([-0.05 1.05 -0.05 1.05]);