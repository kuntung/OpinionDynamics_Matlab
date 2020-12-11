path='C:\Program Files\MATLAB\R2018a\bin\�۵㶯��ѧ\��һƪ���ķ��沿��\�۵�������[0,1]\simulationResults\stepLinedConfidence\';
for k=36
%         ���ƹ۵㴫������Ϊѡ�����ͼ
        figure
        subplot(2,1,1)
        for i=1:N
            plot(1:T,X_result(i,:,k),'Color',[abs(X0(i)),abs(0.7-abs(X0(i))),abs(0.4-abs(X0(i)))]);%��ʾ�۵�ֵ�ķ�Χ��[0,1]����
        %     plot(1:T,2*X(i,:)-1,'Color',[abs(X0(i)),abs(0.7-abs(X0(i))),abs(0.4-abs(X0(i)))]);%��ʾ�۵�ֵ�ķ�Χ��[-1,1]����
            hold on;
        end
        xlim([1 T]);
        xlabel('Time t')
        ylabel('Opinions')
        subplot(2,1,2)
        plot(1:T,frequencyA(k,:),1:T,frequencyB(k,:));
        ylim([0 1]);
        xlim([1 T]);
        xlabel('Time t')
        legend('Percentage of choosing A','Percentage of choosing B')
        figExport(path,epsilo_L(k),epsilo_R(k),a(1),b(1),'-eps');
        figExport(path,epsilo_L(k),epsilo_R(k),a(1),b(1),'-pdf');
        close all;       
end
