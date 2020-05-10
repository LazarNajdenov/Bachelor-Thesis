% Script for selecting the best Laplacian matrix among the following three:
% 1) Unnormalized Laplacian
% 2) Normalized Symmetric Laplacian
% 3) Normalized Random-Walk Laplacian
% For one dataset with increasing size and for each Laplacian, it selects 
% the average accuracies after each run (each run means different dataset 
% size), and put them in a vector size 10, and for safe 
% comparison/reproducibility we fix a rng seed. Then plot with box plot. 
% We expect fewer outliers in the case of Random-Walk Laplacian

clc;
clear;
close all;

warning off
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

% For reproducibility, set rng seed
rng('default');
% Initial dataset size
n = 400;
% Average of accuracies for Unnormalized Laplacian
avgAccU = zeros(9,1);
% Average of accuracies for Normalized Symmetric Laplacian
avgAccS = zeros(9,1);
% Average of accuracies for Normalized Random-Walk Laplacian
avgAccR = zeros(9,1);

for i = 1 : 9
    [avgAccU(i), avgAccS(i), avgAccR(i)] = computeAvgAccLapl(n);
    n = n + 150;
end
%% Plot the minimum, the maximum, the sample median, and the first and 
%  third quartiles, using boxplot for the different accuracies
img = figure;
x = categorical({'Unnormalized','Symmetric', 'RandomWalk'});
x = reordercats(x,{'Unnormalized','Symmetric', 'RandomWalk'});
boxplot([avgAccU, avgAccS, avgAccR], x,'Orientation','horizontal');
xlabel('Accuracy')
ylabel('Laplacian')
set(img,'Renderer', 'painters', 'Position', [500 150 900 600])