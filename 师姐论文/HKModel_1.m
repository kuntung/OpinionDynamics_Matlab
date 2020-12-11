%mamdaniģ�������㷨
clear;
clc;
close all;
warning off;


N=200;        %����������
T=100;         %��������
agent=zeros(N,T);
p2=0.02;%��������Ϊ5%
p1=0.08;%��������Ϊ5%
p=p1+p2;
N2=N*p1;%�����������
N3=N*p2;%�����������   
N1=N-N2-N3;%���׷���߸��������׷�����ǵ�1��N1������������N1+1��N1+N2������������N1+N2+1��N
alphai=0.6;%���׷���߶�������������γ̶� 
betai=0.2;%���׷���߶Ը�����������γ̶�
wi=0.5;%����������Ⱥ��Ŀ�������Ӱ��Ȩ��
d=0.5;%����������Ⱥ��Ŀ�������ֵ
zi=0.5;%����������Ⱥ��Ŀ�������Ӱ��Ȩ��
g=-0.5;%����������Ⱥ��Ŀ�������ֵ

% ��ʼ������Ĺ۵�״̬
load A.mat;  %A�����ﱣ�����ͳһ�ĳ�ʼ�۵� 
agent(1:N,1) = A;
average_initial = ones(1,N)*A/N; 
% agent(1:N1,1) =unifrnd(-0.5,0.5,N1,1);
% agent(N1+1:N1+N2,1) =unifrnd(-0.5,0.5,N2,1);
% agent(N1+N2+1:N,1) =unifrnd(-0.5,0.5,N3,1);
% average_initial = ones(1,N)*agent/N;

%��ʼ�����������ˮƽ
epsilon(1:N1,1)=unifrnd(0,1,N1,1);
%��ʼ�����������ˮƽ
epsilon(N1+1:N1+N2,1)=0.26;
%��ʼ�����������ˮƽ
epsilon(N1+N2+1:N,1)=0.26;

%��ģ���۵���е�������
neigh=zeros(N,T);       %neigh��¼���Ǹ���i��nʱ�̵��ھ�����
SumOpinion=zeros(N,T);  %SumOpinion��¼���Ǹ���i��nʱ�̵��ھӹ۵�ֵ֮��

%�����ڸ�����[1,T]ʱ��������ģ��������˵㡢��ֵ���Ҷ˵�ĸ���
 for n =1:T
     
    %������������i1�۵��״̬
     for  i1=N1+1:N1+N2
         neigh_2=0;%sumWeight��¼������������i1��nʱ�̵�����������Ⱥ���ھ�����
         sumOpin_2=0;%sumOpin��¼������������i1��nʱ�̵Ĺ۵��Ȩ֮��
     %��������j���������i���ھ�����
         for j1=N1+1:N1+N2
          %�ھӶ��巽�����Ը���j��ģ���۵�͸���i�۵�֮���Ƿ�С�ڦ����ж��ھ� 
             if abs(agent(i1,n)-agent(j1,n))<=epsilon(i1,1)
                   neigh_2 = neigh_2 + 1;                 %neigh_2�������i��nʱ�̵��ھ�����
                   sumOpin_2=sumOpin_2+agent(j1,n);  %sumOpin_2��¼���Ǹ���i��nʱ�̵��ھӹ۵�֮��
             else
                   continue;
             end
         end
         %���¸���i��n+1ʱ�̵�ģ���۵�
         if neigh_2>1
           agent(i1,n+1) =(1-wi)*sumOpin_2/neigh_2+wi*d;      %���¸���i��n+1ʱ�̵�ģ���۵�
         end   
     end
     
          
    %���㸺������i2�۵��״̬
     for  i2=N1+N2+1:N
         neigh_3=0;%sumWeight��¼���Ǹ�������i2��nʱ�̵ĸ���������Ⱥ���ھ�����
         sumOpin_3=0;%sumOpin��¼���Ǹ�������i2��nʱ�̵Ĺ۵��Ȩ֮��
     %��������j���������i���ھ�����
         for j2=N1+N2+1:N
          %�ھӶ��巽�����Ը���j��ģ���۵�͸���i�۵�֮���Ƿ�С�ڦ����ж��ھ� 
             if abs(agent(i2,n)-agent(j2,n))<=epsilon(i2,1)
                    neigh_3 = neigh_3 + 1;                 %neigh_3�������i��nʱ�̵��ھ�����
                   sumOpin_3=sumOpin_3+agent(j2,n);  % sumOpin_3��¼���Ǹ���i��nʱ�̵��ھӹ۵�֮��
             else
                   continue;
             end
         end
         %���¸���i��n+1ʱ�̵�ģ���۵�
         if neigh_3>1
           agent(i2,n+1) =(1-zi)*sumOpin_3/ neigh_3+zi*g;      %���¸���i��n+1ʱ�̵�ģ���۵�
         end   
     end
     
      %�������׷����i3�۵��״̬
           for i3=1:N1
             neigh_1=0;%sumWeight��¼����׷����i��nʱ�̵�׷������Ⱥ���ھ�����
             sumOpin_1=0;%sumOpin��¼����׷����i��nʱ�̵Ĺ۵��Ȩ֮��
             neigh_4=0;%sumWeight��¼����׷����i��nʱ�̵�����������Ⱥ���ھ�����
             sumOpin_4=0;%sumOpin��¼����׷����i��nʱ�̵Ĺ۵��Ȩ֮��
             neigh_5=0;%sumWeight��¼����׷����i��nʱ�̵ĸ���������Ⱥ���ھ�����
             sumOpin_5=0;%sumOpin��¼����׷����i��nʱ�̵Ĺ۵��Ȩ֮��
             
            for j4=1:N1
              if abs(agent(i3,n)-agent(j4,n))<=epsilon(i3,1)
                   neigh_1 = neigh_1 + 1;                 %neigh(i,n)�������i��nʱ�̵��ھ�����
                   sumOpin_1=sumOpin_1+agent(j4,n);  %SumOpinion(i,n)��¼���Ǹ���i��nʱ�̵��ھӹ۵�֮��
              else
                   continue;
              end
             end
  
            for j5=N1+1:N1+N2
              if abs(agent(i3,n)-agent(j5,n))<=epsilon(i3,1)
                   neigh_4 = neigh_4 + 1;                 %neigh(i,n)�������i��nʱ�̵��ھ�����
                   sumOpin_4=sumOpin_4+agent(j5,n);  %SumOpinion(i,n)��¼���Ǹ���i��nʱ�̵��ھӹ۵�֮��
              else
                   continue;
              end
            end

            for j6=N1+N2+1:N
              if abs(agent(i3,n)-agent(j6,n))<=epsilon(i3,1)
                   neigh_5 = neigh_5 + 1;                 %neigh(i,n)�������i��nʱ�̵��ھ�����
                   sumOpin_5=sumOpin_5+agent(j6,n);  %SumOpinion(i,n)��¼���Ǹ���i��nʱ�̵��ھӹ۵�֮��
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

           %����׷����i3��k+1ʱ�̹۵�ֵ 
            agent(i3,n+1)=(1-alphai-betai)*sumOpin_1/neigh_1+alphai*b+betai*c; 
           end   
 end
 


opinion_average = agent(1:N,1:T);
%���������ģ���۵�ĵ�������ͼ
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
set(gca,'XTick',[0:5:T-1]);%����Ҫ��ʾ����̶�
set(gca,'YTick',[-0.5:0.1:0.5]);
ylabel('Opinions');
xlabel('Time');

% %��������ĳ�ʼģ�����۵��Լ���ֵģ���۵�ķֲ�ͼ
figure3=figure('Position',[701 198 523 344]);
x=0:0.1:1;
h1=histogram(opinion_average(1:N1,1),'BinWidth',0.1);
hold on;
h2=histogram(opinion_average(1:N1,T),'BinWidth',0.1);
grid on;
set(gca,'XTick',[-0.5:0.1:0.5]);%����Ҫ��ʾ����̶�
set(gca,'YTick',[0:20:N1]);
legend('Initial Opinion','Final Opinion');
ylabel('The number of agents');
xlabel('Opinion range');


%������ͨ����ĳ�ʼ״̬�ڸ��������ϵĸ���
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


%������ͨ���������״̬�ڸ��������ϵĸ���

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

%����Excel��
xlswrite('HKModel_1.xls',data,'�۵����ͳ��','B2');
A2={'��̬';'ĩ̬'};
xlswrite('HKModel_1.xls',A2,'�۵����ͳ��','A2');
B1={'-0.5��-0.4','-0.4��-0.3','-0.3��-0.2','-0.2��-0.1','-0.1��0','0��0.1', '0.1��0.2','0.2��0.3','0.3��0.4','0.4��0.5'};
xlswrite('HKModel_1.xls',B1,'�۵����ͳ��','B1');