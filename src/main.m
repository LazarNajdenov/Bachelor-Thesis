
function [] = main(caseName, blackBox, connFun, simFun, laplMat)
% MAIN main function which clusters a real dataset using different types of
% spectral clustering techniques and evaluates the results.
% 
% Input
% caseName: name of the dataset, i.e. 'ecoli' for the ecoli dataset
% blackBox: flag which decides on using a blackBox spectral clustering;
%           by default it is not used:
%               - 0: No blackBox SC
%               - 1: Use blackBox SC
% connFun:  input value deciding the type connectivity matrix to generate;
%           by default the epsilon-connectivity is used:
%               - 1: use epsilon-connectivity
%               - 2: use kNN
%               - 3: use mkNN
% simFun:   input value deciding the type similarity matrix to generate;
%           by default the CNN similarity measure is used:
%               - 1: use Gaussian similarity 
%               - 2: use max similarity
%               - 3: use local scale similarity
% laplMat:  input value deciding the type of Laplacian matrix to generate;
%           by default the normalized random-walk Laplacian is used:
%               - 1: use unnormalized Laplacian
%               - 2: use normalized symmetric Laplacian
%               - 3: use normalized random-walk Laplacian
    
    clc;
    close all;
    addpath helperFunctions/
    addpath helperFunctions/wgPlot/
    addpath helperFunctions/plotFunctions/
    addpath helperFunctions/computeLaplacians/
    addpath helperFunctions/evaluationFunctions/
    addpath helperFunctions/similarityFunctions/
    addpath helperFunctions/connectivityFunctions/
    addpath datasets/
    
    if nargin < 5, laplMat  = 3; end
    if nargin < 4, simFun   = 4; end
    if nargin < 3, connFun  = 1; end
    if nargin < 2, blackBox = 0; end
    if nargin < 1, error('No file specified'); end
    if (blackBox < 0 || blackBox > 1) || (connFun < 1 || connFun > 3) ... 
            || (simFun < 1 || simFun > 4) || (laplMat < 1 || laplMat > 3) 
        error('The input given is not applicable');
    end
    
    [Pts, label, K] = Generate_OPENML_datasets(caseName);
    
    if blackBox
        
        x_spec          = spectralcluster(Pts, K);
        [x_inferred, ~] = label_data(x_spec, label);
        evaluate_clusters(label, x_inferred, x_spec, Pts, 1, blackBox);
        
    else
        if connFun == 1 && simFun == 4 && laplMat == 3
            epsilon           = heurEps2(Pts);
            G                 = USI_epsilonSimGraph(epsilon,Pts);
            if ~isConnected(G), error('The graph is not connected'); end
            S                 = commonNearNeighborSimilarityFunc(Pts, epsilon);
            W                 = sparse(S .* G);
            nonzero           = nnz(W);
            nrows             = size(W,1);
            fprintf("Adjacency generated : nrows = %d, nnz = %d, nnzr = %d\n",...
                    nrows, nonzero, nonzero/nrows);
            [~, V, P]         = chooseLapl(W, K, laplMat);
            x_spec            = kmeans(V, K,'Display', 'final','Replicates', 10);
            plotter(W, Pts, P, V, x_spec);
            
        else
            [G, kNN]          = chooseConnFun(Pts, connFun);
            if ~isConnected(G), error('The graph is not connected'); end
            S                 = chooseSimFun(Pts, simFun, kNN);
            W                 = sparse(S .* G);
            nonzero           = nnz(W);
            nrows             = size(W,1);
            fprintf("Adjacency generated : nrows = %d, nnz = %d, nnzr = %d\n",...
                    nrows, nonzero, nonzero/nrows);
            [L, V, ~]         = chooseLapl(W, K, laplMat);
            x_spec            = kmeans(V, K,'Display', 'final','Replicates', 10);
            plotter(W, Pts, L, V, x_spec);
            
        end
        
        % Label inferred clustering results
        [x_inferred, ~]  = label_data(x_spec, label);
        
        % Evaluate clustering results, by computing confusion matrix, 
        % accuracy and RatioCut, NormalizedCut     
        evaluate_clusters(label, x_inferred, x_spec, W, 1, blackBox, laplMat);
        
        matName          = strcat(caseName);
        matName          = strcat(matName,'_results.mat');

        if(~strcmp(matName, "NULL"))
            save(matName,'W','label','x_spec')
        end
    end
    
end

