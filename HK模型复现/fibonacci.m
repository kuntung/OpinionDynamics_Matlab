%斐波那契数列计算
N=6;
sequence=ones(1,N);
for i=3:N
    sequence(i)=sequence(i-1)+sequence(i-2);
end
normal=sequence/sum(sequence);
plot(normal);