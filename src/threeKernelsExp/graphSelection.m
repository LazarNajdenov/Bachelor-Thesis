% Script for selecting the best graph construction among three different 
% approaches:
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

addpath ../
addpath ../datasets/
addpath ../helperFunctions/
addpath ../helperFunctions/wgPlot/
addpath ../helperFunctions/plotFunctions/
addpath ../helperFunctions/computeLaplacians/
addpath ../helperFunctions/evaluationFunctions/
addpath ../helperFunctions/similarityFunctions/
addpath ../helperFunctions/connectivityFunctions/


% Retrieve the datapoints and the labels for the given dataset
data = three_kernels(1000);
Pts  = data(:, 1:3);
data_labels = data(:, 3);
% Compute unique values of the labels with no repetition
unique_labels = unique(data_labels);
% Compute the number of unique labels
K = size(unique_labels,1);
%% Compute Epsilon connectivity with Gaussian similarity
epsilon = heurEps3(Pts);
G = USI_epsilonSimGraph(epsilon, Pts);
if ~isConnected(G), error('The graph is not connected'); end
S = chooseSimFun(Pts, 1, 0);
W1 = (S .* G);
%% Compute kNN with Max Gaussian similarity
[G2, kNN] = chooseConnFun(Pts, 2);
if ~isConnected(G2), error('The graph is not connected'); end
S2 = chooseSimFun(Pts, 2, kNN);
W2 = (S2 .* G2);
%% Compute CNN 
epsilon = heurEps3(Pts);
G3 = USI_epsilonSimGraph(epsilon, Pts);
if ~isConnected(G3), error('The graph is not connected'); end
S3 = commonNearNeighborSimilarityFunc(Pts, epsilon);
W3 = (S3 .* G3);
%% Weight Plots
figure;
wgPlot(W1,Pts,'edgeColorMap',jet,'edgeWidth',1);
figure;
wgPlot(W2,Pts,'edgeColorMap',jet,'edgeWidth',1);
figure;
wgPlot(W3,Pts,'edgeColorMap',jet,'edgeWidth',1);
%% Compute Laplacian
[L1, V1, ~] = chooseLapl(W1, K, 1);
[L2, V2, ~] = chooseLapl(W2, K, 1);
[L3, V3, ~] = chooseLapl(W3, K, 1);
%% Compute accuracies, cuts and modularities for 10 iterations and plot the distribution

rng(0);
[~, ~, mAcc1, mCuts1] = computeAccCutModul(W1, V1, K, data_labels,3);
[~, ~, mAcc2, mCuts2] = computeAccCutModul(W2, V2, K, data_labels,3);
[~, ~, mAcc3, mCuts3] = computeAccCutModul(W3, V3, K, data_labels,3);

% p = max(max(acc2),max(cut2));
% h1 = figure;
% plot(1:10, acc2,'LineWidth',2,'Marker','o','MarkerFaceColor','red','MarkerSize',10, 'DisplayName','Accuracies');
% xlabel('Iteration')
% ylabel('Accuracy')
% set(h1,'Renderer', 'painters', 'Position', [500 150 900 600])
% hold on
% plot(1:10, cut2,'LineWidth',2, 'Marker','o','MarkerFaceColor','red','MarkerSize',10, 'DisplayName','RatioCuts');
% axis([1 10 0 p+0.5])
% legend
% hold off
img = figure;
y = [mAcc1, mCuts1; mAcc2, mCuts2; mAcc3, mCuts3];
x = categorical({'Eps-Gauss','kNN-Max','Eps-CNN'});
x = reordercats(x,{'Eps-Gauss','kNN-Max','Eps-CNN'});
b = bar(x,y);
lgd = legend('Accuracy', 'Ratio');
lgd.FontSize = 15;
lgd.Title.String = 'Legend BarPlot';
limit = max(max(y(:,1)),max(y(:,2)));
ylim([0 limit+0.3]);
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom', 'FontSize', 12)
xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize', 12)
set(gca,'fontsize',15)
set(img,'Renderer', 'painters', 'Position', [500 150 900 600])