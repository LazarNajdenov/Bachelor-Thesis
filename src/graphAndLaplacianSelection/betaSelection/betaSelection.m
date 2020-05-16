% IMPORTANT!!! Fine Tuning Step, use it lastly with the modularity
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% Script for comparing the accuracy, Rcut or Ncut, and the modularity got 
% from spectral clustering results for a given dataset, depending on the 
% the different RandomWalk Laplacians for beta values ranging from 1.1 included 
% to 2 excluded.
clc;
clear;
close all;

addpath ../
addpath ../../
addpath ../../datasets/
addpath ../../kNNMaxResults/
addpath ../../helperFunctions/
addpath ../../helperFunctions/wgPlot/
addpath ../../helperFunctions/plotFunctions/
addpath ../../helperFunctions/computeLaplacians/
addpath ../../helperFunctions/evaluationFunctions/
addpath ../../helperFunctions/similarityFunctions/
addpath ../../helperFunctions/connectivityFunctions/


% Retrieve adjacency matrices and labels from artificial datasets
load Aggregation_40NN.mat
WAggr = W;
lAggr = label;

load Compound_20NN.mat
WComp = W;
lComp = label;

load Flame_20NN.mat
WFlam = W;
lFlam = label;

load Jain_20NN.mat
WJain = W;
lJain = label;

load Pathbased_20NN.mat
WPath = W;
lPath = label;

load R15_40NN.mat

WR15 = W;
lR15 = label;

load Spiral_20NN.mat
WSpir = W;
lSpir = label;


%% Compute Random-walk Laplacian with beta going from 1.1 to 1.9 
%  with step size 0.1, and compute accuracies, cuts for 
%  different betas

% For reproducibility
rng('default');

[accAggr, cutAggr, ~] = computeAccCutModulBeta(WAggr, 7, lAggr, 3);
[accComp, cutComp, ~] = computeAccCutModulBeta(WComp, 6, lComp, 3);
[accFlam, cutFlam, ~] = computeAccCutModulBeta(WFlam, 2, lFlam, 3);
[accJain, cutJain, ~] = computeAccCutModulBeta(WJain, 2, lJain, 3);
[accPath, cutPath, ~] = computeAccCutModulBeta(WPath, 3, lPath, 3);
% [accR15, cutR15, ~] = computeAccCutModulBeta(WR15, 15, lR15, 3);
[accSpir, cutSpir, ~] = computeAccCutModulBeta(WSpir, 3, lSpir, 3);
avgAcc = zeros(9, 1);
avgCut = zeros(9, 1);
for i = 1 : 9
    avgAcc(i) = mean([accAggr(i), accComp(i), accFlam(i), accJain(i), accPath(i), accSpir(i)]);
    avgCut(i) = mean([cutAggr(i), cutComp(i), cutFlam(i), cutJain(i), cutPath(i), cutSpir(i)]);
end
%%  Plot the average of the results for each beta
img1 = figure;
plot(1.1:0.1:1.9, avgAcc,'LineWidth',2,'Color', 'black' ,'Marker','o','MarkerFaceColor','cyan','MarkerSize',8);
xlabel('Beta')
ylabel('Accuracy')
set(gca,'fontsize',15)
set(img1,'Renderer', 'painters', 'Position', [400 150 950 600])
img2 = figure;
plot(1.1:0.1:1.9,avgCut,'LineWidth',2,'Color', 'blue' ,'Marker','o','MarkerFaceColor','yellow','MarkerSize',8);
xlabel('Beta')
ylabel('Normalized Cuts')
set(gca,'fontsize',15)
set(img2,'Renderer', 'painters', 'Position', [400 150 950 600])