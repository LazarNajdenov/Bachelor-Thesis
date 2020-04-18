function [] = main(caseName, blackBox, connFun, simFun, laplMat)
% MAIN main function which clusters a real dataset using different types of
% spectral clustering techniques and evaluates the results.
% 
% Input
% caseName: name of the dataset
% blackBox: flag which decides on using a blackBox spectral clustering
% connFun:  input value deciding the type connectivity matrix to generate
% simFun:   input value deciding the type similarity matrix to generate
% laplMat:  input value deciding the type Laplacian matrix to generate
    
    clc;
    close all;
    addpath helperFunctions/
    addpath helperFunctions/wgPlot/
    addpath helperFunctions/plottingFunctions/
    addpath helperFunctions/similarityFunctions/
    addpath helperFunctions/connectivityFunctions/
    
    if nargin < 5, laplMat  = 3; end
    if nargin < 4, simFun   = 4; end
    if nargin < 3, connFun  = 1; end
    if nargin < 2, blackBox = 0; end
    if nargin < 1, error('No file specified'); end
    
    [Pts, label, K] = Generate_OPENML_datasets(caseName);
    
    if blackBox
        % Black box spectral clustering built-in function of matlab
        x_spec           = spectralcluster(Pts, K);
        % Label inferred clustering results
        [x_inferred, ~]  = label_data(x_spec, label);
        evaluate_clusters(label, x_inferred, x_spec, Pts, 1, blackBox);
        
    else
        if connFun == 1 && simFun == 4 && laplMat == 3
            epsilon           = heurEps2(Pts);
            G                 = USI_epsilonSimGraph(epsilon,Pts);
            if ~isConnected(G), error('The graph is not connected'); end
            S                 = commonNearNeighborSimilarityFunc(Pts, epsilon);
            W                 = sparse(S .* G);
            [L, V, x_spec, P] = clusterRows(W, K, laplMat);
            plotter(W, Pts, P, V, x_spec);
        else
            % Generate Connectivity matrix G
            G                 = chooseConnFun(Pts, connFun);
            if ~isConnected(G), error('The graph is not connected'); end
            % Generate Similarity matrix S
            S                 = chooseSimFun(Pts, simFun);
            % Generate Adjacency matrix W             
            W                 = sparse(S .* G);
            nonzero           = nnz(W);
            nrows             = size(W,1);
            fprintf("Adjacency generated : nrows = %d, nnz = %d, nnzr = %d\n",...
                    nrows, nonzero, nonzero/nrows);
            % Generate Laplacian, K smallest eigenvectors, clustering results             
            [L, V, x_spec, ~] = clusterRows(W, K, laplMat);
            % Plot the results             
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

