%mamdani模糊推理算法
clear;
clc;
close all;
warning off;


N=200;        %个体总人数
T=100;         %迭代步数
agent=zeros(N,T);
p2=0.02;%负面领袖为5%
p1=0.08;%正面领袖为5%
p=p1+p2;
N2=N*p1;%正面领袖个数
N3=N*p2;%负面领袖个数   
N1=N-N2-N3;%意见追随者个数，意见追随者是第1：N1，正面领袖是N1+1：N1+N2，负面领袖是N1+N2+1：N
alphai=0.6;%意见追随者对正面领袖的信任程度 
betai=0.2;%意见追随者对负面领袖的信任程度
wi=0.5;%正面领袖子群受目标意见的影响权重
d=0.5;%正面领袖子群的目标意见的值
zi=0.5;%负面领袖子群受目标意见的影响权重
g=-0.5;%负面领袖子群的目标意见的值

% 初始化个体的观点状态
load A.mat;  %A矩阵里保存的是统一的初始观点 
agent(1:N,1) = A;
average_initial = ones(1,N)*A/N; 
% agent(1:N1,1) =unifrnd(-0.5,0.5,N1,1);
% agent(N1+1:N1+N2,1) =unifrnd(-0.5,0.5,N2,1);
% agent(N1+N2+1:N,1) =unifrnd(-0.5,0.5,N3,1);
% average_initial = ones(1,N)*agent/N;

%初始化个体的信任水平
epsilon(1:N1,1)=unifrnd(0,1,N1,1);
%初始化个体的信任水平
epsilon(N1+1:N1+N2,1)=0.26;
%初始化个体的信任水平
epsilon(N1+N2+1:N,1)=0.26;

%对模糊观点进行迭代更新
neigh=zeros(N,T);       %neigh记录的是个体i在n时刻的邻居总数
SumOpinion=zeros(N,T);  %SumOpinion记录的是个体i在n时刻的邻居观点值之和

%计算在个体在[1,T]时间内三角模糊数的左端点、峰值、右端点的更新
 for n =1:T
     
    %计算正面领袖i1观点的状态
     for  i1=N1+1:N1+N2
         neigh_2=0;%sumWeight记录的是正面领袖i1在n时刻的正面领袖子群中邻居总数
         sumOpin_2=0;%sumOpin记录的是正面领袖i1在n时刻的观点加权之和
     %遍历个体j来计算个体i的邻居总数
         for j1=N1+1:N1+N2
          %邻居定义方法：以个体j的模糊观点和个体i观点之差是否小于α来判断邻居 
             if abs(agent(i1,n)-agent(j1,n))<=epsilon(i1,1)
                   neigh_2 = neigh_2 + 1;                 %neigh_2代表个体i在n时刻的邻居总数
                   sumOpin_2=sumOpin_2+agent(j1,n);  %sumOpin_2记录的是个体i在n时刻的邻居观点之和
             else
                   continue;
             end
         end
         %更新个体i在n+1时刻的模糊观点
         if neigh_2>1
           agent(i1,n+1) =(1-wi)*sumOpin_2/neigh_2+wi*d;      %更新个体i在n+1时刻的模糊观点
         end   
     end
     
          
    %计算负面领袖i2观点的状态
     for  i2=N1+N2+1:N
         neigh_3=0;%sumWeight记录的是负面领袖i2在n时刻的负面领袖子群中邻居总数
         sumOpin_3=0;%sumOpin记录的是负面领袖i2在n时刻的观点加权之和
     %遍历个体j来计算个体i的邻居总数
         for j2=N1+N2+1:N
          %邻居定义方法：以个体j的模糊观点和个体i观点之差是否小于α来判断邻居 
             if abs(agent(i2,n)-agent(j2,n))<=epsilon(i2,1)
                    neigh_3 = neigh_3 + 1;                 %neigh_3代表个体i在n时刻的邻居总数
                   sumOpin_3=sumOpin_3+agent(j2,n);  % sumOpin_3记录的是个体i在n时刻的邻居观点之和
             else
                   continue;
             end
         end
         %更新个体i在n+1时刻的模糊观点
         if neigh_3>1
           agent(i2,n+1) =(1-zi)*sumOpin_3/ neigh_3+zi*g;      %更新个体i在n+1时刻的模糊观点
         end   
     end
     
      %计算意见追随者i3观点的状态
           for i3=1:N1
             neigh_1=0;%sumWeight记录的是追随者i在n时刻的追随者子群中邻居总数
             sumOpin_1=0;%sumOpin记录的是追随者i在n时刻的观点加权之和
             neigh_4=0;%sumWeight记录的是追随者i在n时刻的正面领袖子群中邻居总数
             sumOpin_4=0;%sumOpin记录的是追随者i在n时刻的观点加权之和
             neigh_5=0;%sumWeight记录的是追随者i在n时刻的负面领袖子群中邻居总数
             sumOpin_5=0;%sumOpin记录的是追随者i在n时刻的观点加权之和
             
            for j4=1:N1
              if abs(agent(i3,n)-agent(j4,n))<=epsilon(i3,1)
                   neigh_1 = neigh_1 + 1;                 %neigh(i,n)代表个体i在n时刻的邻居总数
                   sumOpin_1=sumOpin_1+agent(j4,n);  %SumOpinion(i,n)记录的是个体i在n时刻的邻居观点之和
              else
                   continue;
              end
             end
  
            for j5=N1+1:N1+N2
              if abs(agent(i3,n)-agent(j5,n))<=epsilon(i3,1)
                   neigh_4 = neigh_4 + 1;                 %neigh(i,n)代表个体i在n时刻的邻居总数
                   sumOpin_4=sumOpin_4+agent(j5,n);  %SumOpinion(i,n)记录的是个体i在n时刻的邻居观点之和
              else
                   continue;
              end
            end

            for j6=N1+N2+1:N
              if abs(agent(i3,n)-agent(j6,n))<=epsilon(i3,1)
                   neigh_5 = neigh_5 + 1;                 %neigh(i,n)代表个体i在n时刻的邻居总数
                   sumOpin_5=sumOpin_5+agent(j6,n);  %SumOpinion(i,n)记录的是个体i在n时刻的邻居观点之和
              else
                   continue;
              end
            end
            
            if neigh_4>1
              b = sumOpin_4/neigh_4;      
            else
                b=0;
                alphai=0;
            end
            
            if neigh_5>1
             c = sumOpin_5/neigh_5;      
            else
             c=0;
             betai=0;
            end

           %更新追随者i3在k+1时刻观点值 
            agent(i3,n+1)=(1-alphai-betai)*sumOpin_1/neigh_1+alphai*b+betai*c; 
           end   
 end
 


opinion_average = agent(1:N,1:T);
%绘制主体的模糊观点的迭代更新图
figure2=figure('Position',[1 1 595 287]);
k=0:T-1;
for i=1:N1
plot(k,opinion_average(i,1:T),'b');
hold on;
end
for i=N1+1:N1+N2
plot(k,opinion_average(i,1:T),'r');
hold on;
end
for i=N1+N2+1:N
plot(k,opinion_average(i,1:T),'k');
hold on;
end
axis([0,T-1,-0.5,0.5]);
set(gca,'XTick',[0:5:T-1]);%设置要显示坐标刻度
set(gca,'YTick',[-0.5:0.1:0.5]);
ylabel('Opinions');
xlabel('Time');

% %绘制主体的初始模糊化观点以及终值模糊观点的分布图
figure3=figure('Position',[701 198 523 344]);
x=0:0.1:1;
h1=histogram(opinion_average(1:N1,1),'BinWidth',0.1);
hold on;
h2=histogram(opinion_average(1:N1,T),'BinWidth',0.1);
grid on;
set(gca,'XTick',[-0.5:0.1:0.5]);%设置要显示坐标刻度
set(gca,'YTick',[0:20:N1]);
legend('Initial Opinion','Final Opinion');
ylabel('The number of agents');
xlabel('Opinion range');


%计算普通个体的初始状态在各个区间上的个数
data=zeros(2,10);
for i=1:N1
    if  agent(i,1)<=-0.4
        data(1,1)=data(1,1)+1;
    elseif agent(i,1)<=-0.3
        data(1,2)=data(1,2)+1;
    elseif agent(i,1)<=-0.2
        data(1,3)=data(1,3)+1;
    elseif agent(i,1)<=-0.1
        data(1,4)=data(1,4)+1;
    elseif agent(i,1)<=0
        data(1,5)=data(1,5)+1;
    elseif agent(i,1)<=0.1
        data(1,6)=data(1,6)+1;
    elseif agent(i,1)<=0.2
        data(1,7)=data(1,7)+1;
    elseif agent(i,1)<=0.3
        data(1,8)=data(1,8)+1;
    elseif agent(i,1)<=0.4
        data(1,9)=data(1,9)+1;
    else 
        data(1,10)=data(1,10)+1;
    end
end


%计算普通个体的最终状态在各个区间上的个数

for i=1:N1
    if  agent(i,T)<=-0.4
        data(2,1)=data(2,1)+1;
    elseif agent(i,T)<=-0.3
        data(2,2)=data(2,2)+1;
    elseif agent(i,T)<=-0.2
        data(2,3)=data(2,3)+1;
    elseif agent(i,T)<=-0.1
        data(2,4)=data(2,4)+1;
    elseif agent(i,T)<=0
        data(2,5)=data(2,5)+1;
    elseif agent(i,T)<=0.1
        data(2,6)=data(2,6)+1;
    elseif agent(i,T)<=0.2
        data(2,7)=data(2,7)+1;
    elseif agent(i,T)<=0.3
        data(2,8)=data(2,8)+1;
    elseif agent(i,T)<=0.4
        data(2,9)=data(2,9)+1;
    else 
        data(2,10)=data(2,10)+1;
    end
end

%生成Excel表
xlswrite('HKModel_1.xls',data,'观点个数统计','B2');
A2={'初态';'末态'};
xlswrite('HKModel_1.xls',A2,'观点个数统计','A2');
B1={'-0.5→-0.4','-0.4→-0.3','-0.3→-0.2','-0.2→-0.1','-0.1→0','0→0.1', '0.1→0.2','0.2→0.3','0.3→0.4','0.4→0.5'};
xlswrite('HKModel_1.xls',B1,'观点个数统计','B1');