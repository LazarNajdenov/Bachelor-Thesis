% Script for selecting the best graph construction among three different 
% approaches with an increasing size dataset and some artificial ones:
% 1) epsilon connectivity graph with Gaussian similarity function
% 2) k-Nearest Neighbor with max Gaussian similarity function
% 3) epsilon connectivity graph with Common Near Neighbor similarity function
% For each of these cases we visualise the graph construction (adjacency matrix) 
% and its weights among the edges.
% Then  by running 10 times k-means on the K smallest eigenvectors of the 
% unnormalized Laplacian it compares the clustering results on the average 
% of both the accuracy and the ratio for each of them.
% From the results we select the one whose ratio/accuracy correlation is
% the best,i.e. higher the accuracy, lower the ratio cut.

clc;
clear;
close all;

addpath ../../
addpath ../../datasets/
addpath ../../helperFunctions/
addpath ../../helperFunctions/wgPlot/
addpath ../../helperFunctions/plotFunctions/
addpath ../../helperFunctions/computeLaplacians/
addpath ../../helperFunctions/evaluationFunctions/
addpath ../../helperFunctions/similarityFunctions/
addpath ../../helperFunctions/connectivityFunctions/

% For reproducibility, set rng seed
rng('default');
% Initial dataset size
n = 400;
% Average of accuracies for Eps-Gau similarity graph
avgAcc1 = zeros(9,1);
% Average of accuracies for kNN-Max similarity graph
avgAcc2 = zeros(9,1);
% Average of accuracies for Eps-Cnn similarity graph
avgAcc3 = zeros(9,1);
% Average of ratiocuts for Eps-Gau similarity graph
avgRatio1 = zeros(9,1);
% Average of ratiocuts for kNN-Max similarity graph
avgRatio2 = zeros(9,1);
% Average of ratiocuts for Eps-Cnn similarity graph
avgRatio3 = zeros(9,1);

for i = 1 : 9
    [avgAcc1(i), avgAcc2(i), avgAcc3(i), avgRatio1(i), avgRatio2(i), avgRatio3(i)] = computeAvgAccRatio(n);
    n = n + 150;
end
mAcc1 = mean(avgAcc1);
mAcc2 = mean(avgAcc2);
mAcc3 = mean(avgAcc3);
mRatio1 = mean(avgRatio1);
mRatio2 = mean(avgRatio2);
mRatio3 = mean(avgRatio3);
%% Compute accuracies and ratios of artificial shape sets
% For reproducibility, set rng seed
rng('default');

% kNN = 20
load Compound6.mat
load Flame2.mat
load Jain2.mat
load Patchbased3.mat
load Spiral3.mat

[compoundAcc1, compoundAcc2, compoundAcc3, compoundRatio1, ...
    compoundRatio2, compoundRatio3] = computeArtificialAccRatio(Compound);
% plotbars(compoundAcc1, compoundRatio1, compoundAcc2, compoundRatio2, ...
%     compoundAcc3, compoundRatio3);
% title('Averages of accuracies and ratiocuts of Compound6 dataset')

[flameAcc1, flameAcc2, flameAcc3, flameRatio1, ...
    flameRatio2, flameRatio3] = computeArtificialAccRatio(Flame);
% plotbars(flameAcc1, flameRatio1, flameAcc2, flameRatio2, ...
%     flameAcc3, flameRatio3);
% title('Averages of accuracies and ratiocuts of Flame2 dataset')

[jainAcc1, jainAcc2, jainAcc3, jainRatio1, ...
    jainRatio2, jainRatio3] = computeArtificialAccRatio(Jain);
% plotbars(jainAcc1, jainRatio1, jainAcc2, jainRatio2, ...
%     jainAcc3, jainRatio3);
% title('Averages of accuracies and ratiocuts of Jain2 dataset')

[patchAcc1, patchAcc2, patchAcc3, patchRatio1, ...
    patchRatio2, patchRatio3] = computeArtificialAccRatio(Patchbased);
% plotbars(patchAcc1, patchRatio1, patchAcc2, patchRatio2, ...
%     patchAcc3, patchRatio3);
% title('Averages of accuracies and ratiocuts of Patchbased3 dataset')

[spiralAcc1, spiralAcc2, spiralAcc3, spiralRatio1, ...
    spiralRatio2, spiralRatio3] = computeArtificialAccRatio(Spiral);
% plotbars(spiralAcc1, spiralRatio1, spiralAcc2, spiralRatio2, ...
%     spiralAcc3, spiralRatio3);
% title('Averages of accuracies and ratiocuts of Spiral3 dataset')

% kNN = 40 datasets
load Aggregation7.mat
load R15.mat

[aggregationAcc1, aggregationAcc2, aggregationAcc3, aggregationRatio1, ...
    aggregationRatio2, aggregationRatio3] = computeArtificialAccRatio(Aggregation);
% plotbars(aggregationAcc1, aggregationRatio1, aggregationAcc2, aggregationRatio2, ...
%     aggregationAcc3, aggregationRatio3);
% title('Averages of accuracies and ratiocuts for Aggregation7 dataset')

[R15Acc1, R15Acc2, R15Acc3, R15Ratio1, ...
   R15Ratio2, R15Ratio3] = computeArtificialAccRatio(R15);
% plotbars(R15Acc1, R15Ratio1, R15Acc2, R15Ratio2, ...
%     R15Acc3, R15Ratio3);
% title('Averages of accuracies and ratiocuts for R15 dataset')

%% Compute averages of accuracies and cuts between all datasets and plot resulting final graph
epsGaussAcc   =  mean([mAcc1,compoundAcc1, flameAcc1, jainAcc1, patchAcc1, ...
    spiralAcc1, aggregationAcc1, R15Acc1]);
epsGaussRatio = trimmean([mRatio1, compoundRatio1, flameRatio1, jainRatio1, ...
    patchRatio1, spiralRatio1, aggregationRatio1, R15Ratio1],40);
kNNMaxAcc     = mean([mAcc2, compoundAcc2, flameAcc2, jainAcc2, patchAcc2,...
    spiralAcc2, aggregationAcc2, R15Acc2]);
kNNMaxRatio   = trimmean([mRatio2, compoundRatio2, flameRatio2, jainRatio2,...
    patchRatio2, spiralRatio2, aggregationRatio2, R15Ratio2],40);
epsCnnAcc     = mean([mAcc3, compoundAcc3, flameAcc3, jainAcc3, patchAcc3,...
    spiralAcc3, aggregationAcc3, R15Acc3]);
epsCnnRatio   = trimmean([mRatio3, compoundRatio3, flameRatio3, jainRatio3,...
    patchRatio3, spiralRatio3, aggregationRatio3, R15Ratio3],40);
plotbars(mAcc1, mRatio1, mAcc2, mRatio2, mAcc3, mRatio3);
title('Averages of accuracies and ratiocuts for 3-kernels with increasing size')
plotbars(epsGaussAcc, epsGaussRatio, kNNMaxAcc, kNNMaxRatio, epsCnnAcc, epsCnnRatio);
title('Averages of accuracies and ratiocuts for all datasets')

