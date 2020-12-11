%绘制不同参数下最终行为的比例相关图
    figure
    plot(epsilo_R,frequencyA(:,T),epsilo_R,frequencyB(:,T))
    hold on;
    set(gca,'XTick',[0:0.05:0.45]);%设置要显示坐标刻度
    set(gca,'YTick',[0:0.05:1]); 
    xlabel('Confidence level');
   legend('Percentage of choosing A','Percentage of choosing B','Location','North');
  grid on
  figExport('-eps','mechanismFrequency')
    figExport('-pdf','mechanismFrequency')