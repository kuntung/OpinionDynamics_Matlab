%mamdaniģ�������㷨
clear;
clc;
close all;
warning off;



N=200;        %����������
T=101;         %��������
agent=zeros(N,T);

% % ��ʼ���ޱ������
% B=full(FreeScale(N));
load B.mat; 
%Create a graph using the adjacency matrix.'OmitSelfLoops�����ԶԽ���,
%'upper��ָ�������ǣ�������ͼ��
G = graph(B);