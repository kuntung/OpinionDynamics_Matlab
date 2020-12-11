%S state substitute by 0,I ---1  R--0
function result=NPO_Diffusion(N,T,lambda,v,gama)
X=zeros(N,T);
stateNum=zeros(3,T-1);%���ɲ�ͬʱ�̸�״̬������
for t=1:N
    X(t,1)=randi(3)-1;%�õ���ʼֵ
end
for i=2:T
    stateS=sum(X(:,i-1)==0);
    stateI=sum(X(:,i-1)==1);
    stateR=sum(X(:,i-1)==2);
    pS2I=lambda*stateI/N;
    stateNum(:,i-1)=[stateS stateI stateR];
%     pS2S=1-pS2I;%�õ�S״̬��̬ת������
    pI2R=gama*stateI/N;
%     pI2I=1-pI2R;
    for j=1:N
       %����һ�����������ȷ����̬ת����ʽ
        temp=rand();
        %����ǰ״̬ΪSʱ
        if X(j,i-1)==0
            if temp<=pS2I
                X(j,i)=1;
            else
                X(j,i)=0;
            end
        end
        %��ǰ״̬ΪIʱ
        if X(j,i-1)==1
            if temp<=pI2R
                X(j,i)=2;
            else
                X(j,i)=1;
            end
        end
        %��ǰ״̬ΪRʱ
        if X(j,i-1)==2
            X(j,i)=2;
        end
    end
end
plot(stateNum(1,:),'r-*');
hold on;
plot(stateNum(2,:),'g-x');
hold on;
plot(stateNum(3,:),'b-o');
hold on;

legend('s','i','r');
result=stateNum;
end