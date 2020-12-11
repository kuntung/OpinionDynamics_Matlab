%mamdani模糊推理算法
clear;
clc;
close all;
warning off;



N=200;        %个体总人数
T=101;         %迭代步数
agent=zeros(N,T);

% % 初始化无标度网络
% B=full(FreeScale(N));
load B.mat; 
%Create a graph using the adjacency matrix.'OmitSelfLoops’忽略对角线,
%'upper’指明上三角（即无向图）
G = graph(B);