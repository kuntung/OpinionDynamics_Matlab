%���Ʋ�ͬ������������Ϊ�ı������ͼ
    figure
    plot(epsilo_R,frequencyA(:,T),epsilo_R,frequencyB(:,T))
    hold on;
    set(gca,'XTick',[0:0.05:0.45]);%����Ҫ��ʾ����̶�
    set(gca,'YTick',[0:0.05:1]); 
    xlabel('Confidence level');
   legend('Percentage of choosing A','Percentage of choosing B','Location','North');
  grid on
  figExport('-eps','mechanismFrequency')
    figExport('-pdf','mechanismFrequency')