p=0:0.01:1;
alpha=0.7;
belta=0.7;
lnP=log(p)-log(1-p);
signA=lnP+log(0.7/0.3);
plot(p,signA)
hold on;
plot([0.5 0.5],[-6 6])
signB=lnP+log(0.3/0.7);
hold on
plot(p,signB)
legend('Observed Action is A','p=0.5','Observed Action is B')

