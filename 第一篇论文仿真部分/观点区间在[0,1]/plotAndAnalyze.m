%用于批量根据不同参数生成并保存图片
clear
epsilo_L=0.25
epsilo_R=0.25
path='C:\Program Files\MATLAB\R2018a\bin\观点动力学\第一篇论文仿真部分\观点区间在[0,1]\simulationResults\stepLinedConfidence\a0.3b0.7\';
a=[0.3];
b=[0.3];
N=200;
T=20;
alpha=0.7;
belta=0.7;
CNT=length(epsilo_R)*length(a);
%参数设定
load testData;
X_result=randi([-1,-1],N,T,CNT);
A_result=zeros(N,T,CNT);
frequencyA=zeros(CNT,T);
frequencyB=zeros(CNT,T);
for k=1:CNT
        [X_result(:,:,k),A_result(:,:,k)]=paperCodeNonRand(N,T,epsilo_L(k),epsilo_R(k),a(1),b(1),alpha,belta);
        %绘制观点传播和行为选择比例图
        figure
        subplot(2,1,1)
        for i=1:N
            plot(1:T,X_result(i,:,k),'Color',[abs(X0unif(i)),abs(0.7-abs(X0unif(i))),abs(0.4-abs(X0unif(i)))]);%显示观点值的范围在[0,1]区间
            hold on;
        end
        xlim([1 T]);
        xlabel('Time t')
        ylabel('Opinions')
% 
        frequencyA(k,:)=sum(A_result(:,:,k)==1)/N;
        frequencyB(k,:)=sum(A_result(:,:,k)==-1)/N;
        subplot(2,1,2)
        plot(1:T,frequencyA(k,:),1:T,frequencyB(k,:));
        ylim([0 1]);
        xlim([1 T]);
        xlabel('Time t')
        legend('Percentage of choosing A','Percentage of choosing B','Location','Best')  
        figExport('-eps','mechanismEvolutionUnif',path,epsilo_L(k),epsilo_R(k),a,b);
        figExport('-pdf','mechanismEvolutionUnif',path,epsilo_L(k),epsilo_R(k),a,b);
%         close all

end

plotOpinionDistribution;
