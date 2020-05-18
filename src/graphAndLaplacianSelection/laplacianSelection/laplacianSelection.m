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
addpath ../../kNNMaxResults/
addpath ../../helperFunctions/
addpath ../../helperFunctions/wgPlot/
addpath ../../helperFunctions/plotFunctions/
addpath ../../helperFunctions/computeLaplacians/
addpath ../../helperFunctions/evaluationFunctions/
addpath ../../helperFunctions/similarityFunctions/
addpath ../../helperFunctions/connectivityFunctions/

betas = 1.1:0.1:1.9;
%% Artificial Datasets Evaluation 
% For reproducibility, set rng seed
rng('default');

load artificialWandLabels.mat

% Aggregation7 dataset kNN = 40
[AggrAcc, AggrRatio, AggrNCut, AggrQ, betaAggr] = computeAccCutLapl(WAggr, lAggr, betas);
% Compound6 dataset kNN = 20
[CompAcc, CompRatio, CompNCut, CompQ, betaComp] = computeAccCutLapl(WComp, lComp, betas);
% Flame2 dataset kNN = 8
[FlamAcc, FlamRatio, FlamNCut, FlamQ, betaFlam] = computeAccCutLapl(WFlam, lFlam, betas);
% Jain2 dataset kNN = 20
[JainAcc, JainRatio, JainNCut, JainQ, betaJain] = computeAccCutLapl(WJain, lJain, betas);
% Pathbased3 dataset kNN = 20
[PathAcc, PathRatio, PathNCut, PathQ, betaPath] = computeAccCutLapl(WPath, lPath, betas);
% R15 dataset kNN = 40
[R15Acc, R15Ratio, R15NCut, R15Q, betaR15]      = computeAccCutLapl(WR15, lR15, betas);
% Spiral3 dataset kNN = 20
[SpirAcc, SpirRatio, SpirNCut, SpirQ, betaSpir] = computeAccCutLapl(WSpir, lSpir, betas);

%% OpenML Datasets Evaluation 

rng('default');
load openmlWandLabels.mat

% Ecoli dataset kNN = 10
[EcolAccU, EcolAccS, EcolAccR, EcolAccB, EcolCutU, ...
    EcolCutS, EcolCutR, EcolCutB] = computeAccCutLapl(WEcol, lEcol);

% Too big dataset:
% Fashion MNIST dataset kNN = 10
[FashAccU, FashAccS, FashAccR, FashAccB, FashCutU, ...
    FashCutS, FashCutR, FashCutB] = computeAccCutLapl(WFash, lFash);


% Iris dataset kNN = 30
[IrisAccU, IrisAccS, IrisAccR, IrisAccB, IrisCutU, ...
    IrisCutS, IrisCutR, IrisCutB] = computeAccCutLapl(WIris, lIris);

% Too big dataset:
% Kmnist dataset kNN = 10
[KmniAccU, KmniAccS, KmniAccR, KmniAccB, KmniCutU, ...
    KmniCutS, KmniCutR, KmniCutB] = computeAccCutLapl(WKmni, lKmni);


% Mice dataset kNN = 10
[MiceAccU, MiceAccS, MiceAccR, MiceAccB, MiceCutU, ...
    MiceCutS, MiceCutR, MiceCutB] = computeAccCutLapl(WMice, lMice);
% Olivetti dataset kNN = 10
[OlivAccU, OlivAccS, OlivAccR, OlivAccB, OlivCutU, ...
    OlivCutS, OlivCutR, OlivCutB] = computeAccCutLapl(WOliv, lOliv);

% Too big dataset:
% Pendigits dataset kNN = 20
[PendAccU, PendAccS, PendAccR, PendAccB, PendCutU, ...
    PendCutS, PendCutR, PendCutB] = computeAccCutLapl(WPend, lPend);

% Gives V with Complex numbers the RandomWalk 
% Plants dataset kNN = 10
[PlantAccU, PlantAccS, PlantAccR, PlantAccB, PlantCutU, ...
    PlantCutS, PlantCutR, PlantCutB, V3] = computeAccCutLapl(WPlant, lPlant);
% Spectro dataset kNN = 10
[SpectAccU, SpectAccS, SpectAccR, SpectAccB, SpectCutU, ...
    SpectCutS, SpectCutR, SpectCutB, SpectQU, SpectQS, SpectQR, SpectQB] = computeAccCutLapl(WSpect, lSpect);


% Umist dataset kNN = 10
[UmisAccU, UmisAccS, UmisAccR, UmisAccB, UmisCutU, ...
    UmisCutS, UmisCutR, UmisCutB] = computeAccCutLapl(WUmis, lUmis);
% Vehicle dataset kNN = 10
[VehiAccU, VehiAccS, VehiAccR, VehiAccB, VehiCutU, ...
    VehiCutS, VehiCutR, VehiCutB] = computeAccCutLapl(WVehi, lVehi);

%% Plot the minimum, the maximum, the sample median, and the first and 
%  third quartiles, using boxplot for the different accuracies
img = figure;
x = categorical({'Unnormalized','Symmetric', 'RandomWalk'});
x = reordercats(x,{'Unnormalized','Symmetric', 'RandomWalk'});
boxplot([avgAccU, avgAccS, avgAccR], x,'Orientation','horizontal');
xlabel('Accuracy')
ylabel('Laplacian')
set(img,'Renderer', 'painters', 'Position', [500 150 900 600])