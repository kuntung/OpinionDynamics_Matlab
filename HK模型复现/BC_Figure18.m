%输入格式为BC_Figure17(观点个数，时间T，信任区间和)
function BC_Figure18(N,T,epsilo_bar,m)  
X=zeros(N,T); %opinion profile
X0=rand(N,1); %random initial opinion profile
X(:,1)=X0;
Z=zeros(100,26);
%更新迭代观点
    for i=2:T
        for j=1:N
            sum=0;
            cnt=0;
%              m=(e-1)*0.04; %得到m
             belta_r=m*X(j,i-1)+(1-m)/2; %得到βr
             belta_l=1-belta_r;
             epsilo_R=belta_r*epsilo_bar;
             epsilo_L=belta_l*epsilo_bar;
            for k=1:N
                dis=X(k,i-1)-X(j,i-1);
                if (dis<=epsilo_R) && (dis>=-epsilo_L)
                    sum=X(k,i-1)+sum;
                    cnt=cnt+1;
                end
            end
            X(j,i)=sum/cnt;
        end
    end
%     for op=1:100
%         Z(op,e)=length(find(roundn(X(:,T),-2)==op/100))/N;
%     end
% figure(1)
% C =del2(Z');
% surf(Z',C,'FaceLighting','gouraud','LineWidth',0.3);
% xlabel('opinion')
% ylabel('m')
% zlabel('frequency')
% hold on;
figure(2)
delta=diff(X');
% subplot(2,1,2);
plot(0:1:T-2,delta);
%shading interp
for i=1:N
    plot(0:T-1,X(i,:),'Color',[X0(i),abs(0.7-X0(i)),abs(0.4-X0(i))]);
    hold on 
end
end
