% For 1 dataset with increasing size, select the average ACC after each 
% run (each run means different dataset size), and put them in a vector. 
% Vector of size 10, for safe comparison. Fix rng seed. Then plot with box 
% plot. We expect fewer outliers in the case of L_rw.



% Script for comparing the accuracy and the cut got of the spectral clustering 
% results for a given dataset, after running k-means 10 times, 
% depending on the different Laplacian given
clc;
clear;
close all;
addpath ../
addpath ../helperFunctions/
addpath ../helperFunctions/wgPlot/
addpath ../helperFunctions/plotFunctions/
addpath ../helperFunctions/computeLaplacians/
addpath ../helperFunctions/evaluationFunctions/
addpath ../helperFunctions/similarityFunctions/
addpath ../helperFunctions/connectivityFunctions

% Generate adjacencies matrices for OPENML datasets
caseName        = 'ecoli';
[Pts, label, K] = Generate_OPENML_datasets(caseName);
%% Use connectivity and similarity function to generate adjacency matrix
connFun         = 2;
[G, kNN]               = chooseConnFun(Pts, connFun);
if ~isConnected(G), error('The graph is not connected'); end
simFun          = 2;
S               = chooseSimFun(Pts, simFun, kNN);
W               = sparse(S .* G);
%% Compute different Laplacians
[~, V1, ~]       = chooseLapl(W, K, 1);
% Use symmetric normalized Laplacian
[~, V2, ~]       = chooseLapl(W, K, 2);
% Use normalized Random-walk Laplacian
[~, V3, ~]       = chooseLapl(W, K, 3);
%% Compute accuracies, cuts and modularities and plot the minimum, 
%  the maximum, the sample median, and the first and third quartiles, using
%  boxplot
% For reproducibility
rng(0);
[acc1, cut1, modul1] = computeAccCutModul(W, V1, K, label,1);
[acc2, cut2, modul2] = computeAccCutModul(W, V2, K, label,2);
[acc3, cut3, modul3] = computeAccCutModul(W, V3, K, label,3);
figure(1);
boxplot([acc1, acc2, acc3],{'Unnormalized','Symmetric', 'RandomWalk'},'Orientation','horizontal');
xlabel('Laplacians')
ylabel('Accuracy')
figure(2);
boxplot([cut2, cut3],{'Symmetric', 'RandomWalk'},'Orientation','horizontal');
xlabel('Laplacians')
ylabel('Normalized Cuts')