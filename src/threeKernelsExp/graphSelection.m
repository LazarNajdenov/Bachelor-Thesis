% Script for selecting the best graph construction among three different 
% approaches with an increasing size dataset:
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
% data = twospirals();
Pts  = data(:, 1:2);
data_labels = data(:, 3);
% Compute unique values of the labels with no repetition
unique_labels = unique(data_labels);
% Compute the number of unique labels
K = size(unique_labels,1);

Pts = double(Pts);
n = size(Pts,1);
label = zeros(n,1);

% Returns the labels normalized(from 0 to n)
for i = 1:n
    % Returns the index of the array unique_labels that matches the value i 
    % of the original data_label
    label(i)  = find(unique_labels == data_labels(i))-1; %0 based labels
end
%% Compute Epsilon connectivity with Gaussian similarity
epsilon = heurEps3(Pts);
G = USI_epsilonSimGraph(epsilon, Pts);
if ~isConnected(G), error('The graph is not connected'); end
S = gaussSimilarityfunc(Pts);
W1 = sparse(S .* G);
%% Compute kNN with Max Gaussian similarity
% Choose kNN = 20
G2 = kNNConGraph(Pts, 20);
if ~isConnected(G2), error('The graph is not connected'); end
S2 = maxSimilarityfunc(Pts, 20);
W2 = sparse(S2 .* G2);
%% Compute CNN
S3 = commonNearNeighborSimilarityFunc(Pts, epsilon);
W3 = sparse(S3 .* G);
%% Weight Plots
figure;
wgPlot(W1,Pts,'edgeColorMap',jet,'edgeWidth',1);
figure;
wgPlot(W2,Pts,'edgeColorMap',jet,'edgeWidth',1);
figure;
wgPlot(W3,Pts,'edgeColorMap',jet,'edgeWidth',1);
%% Compute Laplacian
[L1, V1, ~, l1] = chooseLapl(W1, K, 1);
[L2, V2, ~, l2] = chooseLapl(W2, K, 1);
[L3, V3, ~, l3] = chooseLapl(W3, K, 1);
%% Compute accuracies, cuts for 10 iterations and plot the distribution

% For reproducibility
rng('default');
[~, ~, mAcc1, mCut1, x1] = computeAccCutModul(W1, V1, K, label,1);
[~, ~, mAcc2, mCut2, x2] = computeAccCutModul(W2, V2, K, label,1);
[~, ~, mAcc3, mCut3, x3] = computeAccCutModul(W3, V3, K, label,1);

img = figure;
y = [mAcc1, mCut1; mAcc2, mCut2; mAcc3, mCut3];
x = categorical({'Eps-Gauss','kNN-Max', 'Eps-Cnn'});
x = reordercats(x,{'Eps-Gauss','kNN-Max', 'Eps-Cnn'});
b = bar(x,y);
lgd = legend('Accuracy', 'Ratio');
lgd.FontSize = 15;
lgd.Title.String = 'Legend BarPlot';
limit = max(max(y(:,1)),max(y(:,2)));
ylim([0 limit+2]);
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

figure;
gplotmap(W1, Pts, x1(:, end));
figure;
gplotmap(W2, Pts, x2(:,end));
figure;
gplotmap(W3, Pts, x3(:, end));