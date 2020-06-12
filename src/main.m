function main(caseName, blackBox, simGraph, laplMat)
% MAIN main function which clusters a real-world dataset using different types of
% spectral clustering techniques and evaluates the results.
% 
% Input
% caseName: name of the dataset, i.e. 'ecoli' for the Ecoli_all.mat dataset
% blackBox: flag which decides on using a blackBox spectral clustering;
%           by default it is not used:
%               - 0: No blackBox SC
%               - 1: Use blackBox SC
% simGraph: input value deciding the type connectivity and similarity 
%           function configuration used for generating the adjacency matrix,
%           by default the kNN-Max configuration is used:
%               - 1: use kNN-Max
%               - 2: use kNN-Gauss
%               - 3: use kNN-Local
%               - 4: use eps-Gauss
%               - 5: use eps-CNN
%               - 6: use mkNN-Max
%               - 7: use mkNN-Gauss
%               - 8: use mkNN-Local
% laplMat:  input value deciding the type of Laplacian matrix to generate 
%           from the adjacency matrix, by default the normalized random-walk 
%           Laplacian is used:
%               - 1: use unnormalized Laplacian
%               - 2: use normalized symmetric Laplacian
%               - 3: use normalized random-walk Laplacian
    
    clc;
    close all;
    warning off;
    addpath generatedArtificialDatasets/
    addpath helperFunctions/
    addpath helperFunctions/wgPlot/
    addpath helperFunctions/plotFunctions/
    addpath helperFunctions/computeLaplacians/
    addpath helperFunctions/evaluationFunctions/
    addpath helperFunctions/similarityFunctions/
    addpath helperFunctions/connectivityFunctions/
    
    if nargin < 4, laplMat  = 3; end
    if nargin < 3, simGraph = 1; end
    if nargin < 2, blackBox = 0; end
    if nargin < 1, error('No file specified'); end
    if (blackBox < 0 || blackBox > 1) || (simGraph < 1 || simGraph > 8) ...
            || (laplMat < 1 || laplMat > 3) 
        error('The input given is not applicable');
    end
    
    [Pts, label, K] = Generate_OPENML_datasets(caseName);
    
    % Use the spectral clustering already implemented in matlab     
    if blackBox
        
        x_spec          = spectralcluster(Pts, K);
        [x_inferred, ~] = label_data(x_spec, label);
        evaluate_clusters(label, x_inferred, x_spec, Pts, 1, blackBox);
        
    else

        W       = computeSimGraph(Pts, simGraph);
        nonzero = nnz(W);
        nrows   = size(W,1);
        fprintf("Adjacency generated : nrows = %d, nnz = %d, nnzr = %d\n",...
                nrows, nonzero, nonzero/nrows);
        [V, ~]  = chooseLapl(W, K, laplMat);
        rng('default')
        x_spec  = kmeans(V, K,'Replicates', 10);
        
        % Label inferred clustering results
        [x_inferred, ~] = label_data(x_spec, label);
        
        % Evaluate clustering results, by computing confusion matrix, 
        % accuracy and RatioCut, NormalizedCut     
        evaluate_clusters(label, x_inferred, x_spec, W, 1, blackBox);
        
        matName = strcat(caseName);
        matName = strcat(matName,'_results.mat');
        
        if(~strcmp(matName, "NULL"))
            save(matName,'W','label')
        end
    end
    
end

