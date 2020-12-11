x1=-1:0.01:-0.75;
x2=-0.75:0.01:-0.25;
x3=-0.25:0.01:0;
y1=zeros(1,size(x1,2));
y2=exp(x2);
y3=ones(1,size(x3,2));
% x=[x1 x2 x3];
% y=[y1 y2 y3];
plot(-x1,y1,'b');
hold on;
plot(-x2,y2,'b');
hold on;
plot(-x3,y3,'b');
grid on;
axis([-0.03 1.03 -0.03 1.03]);
xlabel('Difference of any two agents')
ylabel('The corresponding weight')