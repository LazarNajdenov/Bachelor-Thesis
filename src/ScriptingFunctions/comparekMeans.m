% Script for comparing the accuracy and the cut got of the spectral clustering 
% results for a given dataset, after running k-means 10 times, 
% depending on the different connectivity, similarity functions and Laplacian given
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
G               = chooseConnFun(Pts, connFun);
if ~isConnected(G), error('The graph is not connected'); end
simFun          = 2;
S               = chooseSimFun(Pts, simFun);
W               = sparse(S .* G);
%% Compute Laplacian
laplMat         = 3; 
[~, V, ~]       = chooseLapl(W, K, laplMat);
%% Compute accuracies, cuts and modularities for 10 iterations and plot the distribution
% For reproducibility
rng(0);
[acc, cut, modul] = computeAccCutModul(W, V, K, label,laplMat);
h1 = figure(1);
plot(1:10, acc,'LineWidth',2,'Marker','o','MarkerFaceColor','red','MarkerSize',10);
xlabel('Iteration')
ylabel('Accuracy')
set(h1,'Renderer', 'painters', 'Position', [500 150 900 600])
h2 = figure(2);
plot(1:10, cut,'LineWidth',2,'Marker','o','MarkerFaceColor','red','MarkerSize',10);
xlabel('Iteration')
ylabel('Cuts')
set(h2,'Renderer', 'painters', 'Position', [500 150 900 600])
h3 = figure(3);
plot(1:10, modul,'LineWidth',2,'Marker','o','MarkerFaceColor','red','MarkerSize',10);
xlabel('Iteration')
set(h3,'Renderer', 'painters', 'Position', [500 150 900 600])
ylabel('Modularity')