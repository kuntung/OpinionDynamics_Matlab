epsilo=0.4;
x1=-1:0.01:-epsilo;
x2=-epsilo:0.01:0;
y1=zeros(1,size(x1,2));
y2=ones(1,size(x2,2));
% x=[x1 x2 x3];
% y=[y1 y2 y3];
plot(-x1,y1,'b');
hold on;
plot(-x2,y2,'b');
hold on;
grid on;
axis([-0.03 1.03 -0.05 1.03]);
xlabel('Difference of any two agents')
ylabel('The correspond weight')