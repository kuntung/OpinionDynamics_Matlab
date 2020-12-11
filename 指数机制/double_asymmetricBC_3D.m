%%%第一部分，绘制epsilonL_min epsilonL_max左半部分,opinion independent BC
for i=11:-1:1
    k=(i-1)/10;
    epsilonRmax=0.7;epsilonRmin=0.4;
    epsilonLmax=epsilonRmax*k;
    epsilonLmin=epsilonRmin*k;
    x1=-1:0.01:-epsilonLmax;
    x2=-epsilonLmax:0.01:-epsilonLmin;
    x3=-epsilonLmin:0.01:0;%%左半部分坐标划分完毕
    y1=zeros(1,size(x1,2));
    y2=exp(x2);
    y3=ones(1,size(x3,2));
    % plot(x1,y1,'r');
    % hold on;
    % plot(x2,y2,'r');
    % hold on;
    % plot(x3,y3,'r');
    % grid on;
    %左半部分绘制完毕
    x4=0:0.01:epsilonRmin;
    x5=epsilonRmin:0.01:epsilonRmax;
    x6=epsilonRmax:0.01:1;
    y4=ones(1,size(x4,2));
    y5=exp(-x5);
    y6=zeros(1,size(x6,2));
    % plot(x4,y4,'g');
    % hold on;
    % plot(x5,y5,'g');
    % hold on;
    % plot(x6,y6,'g');
    x=[x1 x2 x3 x4 x5 x6];
    y=[y1 y2 y3 y4 y5 y6];
    [xx, yy]=meshgrid(x,y);    
     mesh(yy);
    hold on;
end
