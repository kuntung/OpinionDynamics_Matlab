%���Ƴ�ʼ��ĩ̬�۵�ֲ�ͼ
warning off;
for i=1:CNT
    figure
    h1=histogram(X_result(:,1,i),'BinWidth',0.1);
    hold on;
     set(gca,'XTick',[0:0.1:1]);%����Ҫ��ʾ����̶�
    set(gca,'YTick',[0:20:N]); 
    ylabel('The number of agents');
    xlabel('Opinion range');
    h2=histogram(X_result(:,T,i),'BinWidth',0.1);
    grid on;   
   legend('Initial Opinions','Final Opinions','Location','North');
        figExport('-eps','mechanismDistributionUnif',path,epsilo_L(i),epsilo_R(i),a,b);
        figExport('-pdf','mechanismDistributionUnif',path,epsilo_L(i),epsilo_R(i),a,b);
%         close all
end

