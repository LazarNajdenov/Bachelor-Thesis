% IMPORTANT!!! Fine Tuning Step, use it lastly with the modularity
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% Script for comparing the accuracy, Rcut or Ncut, and the modularity got 
% from spectral clustering results for a given dataset, depending on the 
% the different RandomWalk Laplacians for beta values ranging from 1 included 
% to 2 excluded.
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
betas = {'beta = 1','beta = 1.1','beta = 1.2', 'beta = 1.3','beta = 1.4'...
    'beta = 1.5', 'beta = 1.6', 'beta = 1.7','beta = 1.8','beta = 1.9'};

% Generate adjacencies matrices for OPENML datasets
caseName        = 'ecoli';
[Pts, label, K] = Generate_OPENML_datasets(caseName);
%% Use connectivity and similarity function to generate adjacency matrix
connFun         = 2;
[G, kNN]        = chooseConnFun(Pts, connFun);
if ~isConnected(G), error('The graph is not connected'); end
simFun          = 2;
S               = chooseSimFun(Pts, simFun, kNN);
W               = sparse(S .* G);
%% Compute Random-walk Laplacian with beta going from 1 to 2 
%  with step size 0.1, and compute accuracies, cuts and modularities for 
%  different betas, and plot the minimum, the maximum, the sample median, 
%  and the first and third quartiles.

% For reproducibility
rng(0);
[acc, cut, modul] = computeAccCutModulBeta(W, K, label, 3);
figure(1);
plot(1:0.1:1.9, acc,'LineWidth',2,'Marker','o','MarkerFaceColor','red','MarkerSize',10);
xlabel('Beta')
ylabel('Accuracy')
figure(2);
plot(1:0.1:1.9,cut,'LineWidth',2,'Marker','o','MarkerFaceColor','red','MarkerSize',10);
xlabel('Beta')
ylabel('Normalized Cuts')
figure(3);
plot(1:0.1:1.9,modul,'LineWidth',2,'Marker','o','MarkerFaceColor','red','MarkerSize',10);
xlabel('Beta')
ylabel('Modularity')