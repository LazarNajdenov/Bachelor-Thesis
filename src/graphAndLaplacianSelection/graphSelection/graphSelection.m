% Script for selecting the best graph construction among three different 
% approaches with an increasing size dataset and some artificial ones:
% 1) epsilon connectivity graph with Gaussian similarity function
% 2) k-Nearest Neighbor with max Gaussian similarity function
% 3) epsilon connectivity graph with Common Near Neighbor similarity function
% For each of these cases we visualise the graph construction (adjacency matrix) 
% and its weights among the edges.
% Then  by running 9 times k-means on the K smallest eigenvectors of the 
% unnormalized Laplacian it compares the clustering results on the average 
% of both the accuracy and the ratio for each of them.
% From the results we select the one whose ratio/accuracy correlation is
% the best,i.e. higher the accuracy, lower the ratio cut., based on the 9 
% increasing size iterations 

clc;
clear;
close all;

addpath ../
addpath ../../
addpath ../../datasets/
addpath ../../helperFunctions/
addpath ../../helperFunctions/wgPlot/
addpath ../../helperFunctions/plotFunctions/
addpath ../../helperFunctions/computeLaplacians/
addpath ../../helperFunctions/evaluationFunctions/
addpath ../../helperFunctions/similarityFunctions/
addpath ../../helperFunctions/connectivityFunctions/

For reproducibility, set rng seed
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
%% Plot accuracies
x = 600:225:2400;
img1 = figure;
p1 = plot(x, avgAcc1,'LineWidth',2,'Color', 'black' ,'Marker','o','MarkerFaceColor','cyan','MarkerSize',8);
hold on;
p2 = plot(x, avgAcc2,'LineWidth',2,'Color', [0.9100    0.4100    0.1700] ,'Marker','o','MarkerFaceColor','blue','MarkerSize',8);
p3 = plot(x, avgAcc3,'LineWidth',2,'Color', 'green' ,'Marker','o','MarkerFaceColor','yellow','MarkerSize',8);
hold off;
xlabel('Size');
ylabel('Accuracy');
axis([600 2400 0.6 1 + 0.1]);
xticks(600:225:2400);
set(gca,'fontsize',15);
set(img1,'Renderer', 'painters', 'Position', [400 150 950 600]);
h = [p1;p2;p3];
lgd = legend(h, 'Eps-Gauss', 'kNN-Max', 'Eps-Cnn','Location','BestOutside');
lgd.FontSize = 15;
lgd.Title.String = 'Configurations';
% Plot ratios
rmax = max([max(avgRatio1), max(avgRatio2), max(avgRatio3)]);
img4 = figure;
p4 = plot(x, avgRatio1,'LineWidth',2,'Color', 'black' ,'Marker','o','MarkerFaceColor','cyan','MarkerSize',8);
hold on;
p5 = plot(x, avgRatio2,'LineWidth',2,'Color', [0.9100    0.4100    0.1700],'Marker','o','MarkerFaceColor','blue','MarkerSize',8);
p6 = plot(x, avgRatio3,'LineWidth',2,'Color', 'green' ,'Marker','o','MarkerFaceColor','yellow','MarkerSize',8);
hold off;
axis([600 2400 -0.5 rmax + 0.1]);
xticks(600:225:2400);
yticks(-0.5:0.5:6);
xlabel('Size');
ylabel('Ratiocut');
set(gca,'fontsize',15)
set(img4,'Renderer', 'painters', 'Position', [400 150 950 600])
h2 = [p4;p5;p6];
lgd = legend(h2, 'Eps-Gauss', 'kNN-Max', 'Eps-Cnn','Location','BestOutside');
lgd.FontSize = 15;
lgd.Title.String = 'Configurations';

%% Compute accuracies and ratios of artificial shape sets
% For reproducibility, set rng seed
addpath ../
addpath ../../
addpath ../../datasets/
addpath ../../helperFunctions/
addpath ../../helperFunctions/wgPlot/
addpath ../../helperFunctions/plotFunctions/
addpath ../../helperFunctions/computeLaplacians/
addpath ../../helperFunctions/evaluationFunctions/
addpath ../../helperFunctions/similarityFunctions/
addpath ../../helperFunctions/connectivityFunctions/
rng('default');

% kNN = 20

load Compound6.mat
load Flame2.mat
load Jain2.mat
load Patchbased3.mat
load Spiral3.mat

[compoundAcc1, compoundAcc2, compoundAcc3, compoundRatio1, ...
    compoundRatio2, compoundRatio3] = computeArtificialAccRatio(Compound);

[flameAcc1, flameAcc2, flameAcc3, flameRatio1, ...
    flameRatio2, flameRatio3] = computeArtificialAccRatio(Flame);

[jainAcc1, jainAcc2, jainAcc3, jainRatio1, ...
    jainRatio2, jainRatio3] = computeArtificialAccRatio(Jain);

[patchAcc1, patchAcc2, patchAcc3, patchRatio1, ...
    patchRatio2, patchRatio3] = computeArtificialAccRatio(Patchbased);

[spiralAcc1, spiralAcc2, spiralAcc3, spiralRatio1, ...
    spiralRatio2, spiralRatio3] = computeArtificialAccRatio(Spiral);

% kNN = 40 datasets
load Aggregation7.mat
load R15.mat

[aggregationAcc1, aggregationAcc2, aggregationAcc3, aggregationRatio1, ...
    aggregationRatio2, aggregationRatio3] = computeArtificialAccRatio(Aggregation);

[R15Acc1, R15Acc2, R15Acc3, R15Ratio1, ...
   R15Ratio2, R15Ratio3] = computeArtificialAccRatio(R15);

%% Plot resulting graph
plotbars(mAcc1, mRatio1, mAcc2, mRatio2, mAcc3, mRatio3);
title('Averages of accuracies and ratiocuts for 3-kernels with increasing size')
% plotbars(epsGaussAcc, epsGaussRatio, kNNMaxAcc, kNNMaxRatio, epsCnnAcc, epsCnnRatio);
% title('Averages of accuracies and ratiocuts for all datasets')

