function [W,S,G,x_spec, connected] = benchmarkingScript(points, K)
% A Benchmarking Script that takes the coordinate list from a dataset and,
% depending on which connectivity graph construction and similarity
% function we choose, it gives us: 
% 
%   - if the corresponding graph is connected,
%   - plots the adjacency matrix
%   - plots the eigenvector representation of the graph taken from the Laplacian,  
%   - plots the weighted graph from the adjacency matrix and vertices coordinate, 
%   - plots the spectral clustering results
% 
% INPUT:
%   - K: Number of clusters we want and if not specified, K = 2 by default 
%   - Requests user input through 'input' function, in order to choose
%   which type of connectivity matrix G to construct:
%       - 1: epsilon-similarity-graph
%       - 2: kNN (k-nearest-neighbor)
%       - 3: mutual kNN (k-nearest-neighbor)
%   and in order to choose the similarity function to obtain the similarity
%   matrix S:
%       - 1: Gaussian Similarity Function
%       - 2: Max Gaussian Similarity Function
%       - 3: Extended Gaussian Similarity Function
%       - 4: Common Near Neighbor Similarity Function
%   

%     if nargin < 1
%         K = 2;
%     end
    
    warning off
    addpath datasets
    addpath helperFunctions/
    addpath helperFunctions/connectivityFunctions/
    addpath helperFunctions/similarityFunctions/
    addpath helperFunctions/plottingFunctions/
    
   
    done = false;
    while (~done)
        connGraph = input('Choose the type of connectivity matrix construction G \n');
        if connGraph == 1 % Epsilon Connectivity Matrix

            epsilon = heurEps2(points);
            
            [G] = USI_epsilonSimGraph(epsilon,points);
            
            if not(isConnected(G))
                fprintf('The graph is not connected.\n');
                S = 0;
                W = 0;
                x_spec = 0;
                connected = 0;
                return;
            end
            
            connected = 1;
            [S] = chooseSimFun(points, epsilon);
            W = sparse(S .* G);
            [L, V, x_spec] = clusterRows(W, K);
            plotter(W, points, L, V, x_spec);
        
        elseif connGraph == 2 % kNN Connectivity Matrix
            epsilon = heurEps2(points);
            [G] = kNNConGraph(points,10);
            
            if not(isConnected(G))
                fprintf('The graph is not connected.\n');
                S = 0;
                W = 0;
                x_spec = 0;
                connected = 0;
                return;
            end
            
            connected = 1;
            [S] = chooseSimFun(points, epsilon);
            W = sparse(S .* G);
            [L, V, x_spec] = clusterRows(W, K);
            plotter(W, points, L, V, x_spec);
            
        elseif connGraph == 3 % mkNN Connectivity Matrix
            epsilon = heurEps2(points);
            [G] = mkNNConGraph(points,10);
            
            if not(isConnected(G))
                fprintf('The graph is not connected.\n');
                S = 0;
                W = 0;
                x_spec = 0;
                connected = 0;
                return;
            end
            
            connected = 1;
            [S] = chooseSimFun(points, epsilon);
            W = sparse(S .* G);
            [L, V, x_spec] = clusterRows(W, K);
            plotter(W, points, L, V, x_spec);
            
        else
            fprintf('You have to choose a number from 1 to 3\n');
            continue;
        end
        done = true;
    end
end