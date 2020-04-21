% Script for comparing the accuracy and the cut got of the spectral clustering 
% results for a given dataset, after running k-means 10 times, 
% depending on the different option given

clc;
close all;
addpath helperFunctions/
addpath helperFunctions/wgPlot/
addpath helperFunctions/plotFunctions/
addpath helperFunctions/computeLaplacians/
addpath helperFunctions/evaluationFunctions/
addpath helperFunctions/similarityFunctions/
addpath helperFunctions/connectivityFunctions
% Generate adjacencies matrices for OPENML datasets
caseName        = 'ecoli';
[Pts, label, K] = Generate_OPENML_datasets(caseName);
connFunc        = 1;
simFunc         = 1;
laplMat         = 1;


