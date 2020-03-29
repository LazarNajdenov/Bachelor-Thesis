function [W,S,G,x_spec] = benchmarkingScript(points,K)
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
%       - 4: CNN (Common-near-neighbor)
%   and in order to choose the similarity function to obtain the similarity
%   matrix S:
%       - 1: Gaussian Similarity Function
%       - 2: Max Gaussian Similarity Function
%       - 3: Extended Gaussian Similarity Function
%       - 4: CNN similarity measure
%   

%     if nargin < 1
%         K = 2;
%     end
    
    warning off
    addpath datasets
    addpath helperFunctions/
    addpath helperFunctions/wgPlot/
   
%     [points,~,~,~,~,~] = getPoints();
    
    done = false;
    while (~done)
        connGraph = input('Choose the type of connectivity matrix construction G \n');
        if connGraph == 1 % Epsilon Connectivity Matrix
            scatter(points(:,1), points(:,2));
            [S] = gaussSimilarityfunc(points);
            
            % Find the minimal spanning tree of the full graph
            % in order to determine epsilon,that is the length of the longest
            % edge in a minimal spanning tree of the fully connected graph 
            % on the data points.
            minimalSpanningTree = minSpanTree(S);
            epsilon = max(max(minimalSpanningTree));
            
            [G] = USI_epsilonSimGraph(epsilon,points);
            
            if not(isConnected(G))
                fprintf('The graph is not connected.\n'); 
            end
            
            W = sparse(S .* G);
            x_spec = plotter(W, K, points);

        elseif connGraph == 2 % kNN Connectivity Matrix
            scatter(points(:,1), points(:,2));
            [G] = kNNConGraph(points,10);
            
            if not(isConnected(G))
                fprintf('The graph is not connected.\n'); 
            end
            
            [S] = chooseSimFun(points);
            W = sparse(S .* G);
            spy(W)
%             if (det(W) ~= 0)
            x_spec = plotter(W, K, points);
%             end
            
        elseif connGraph == 3 % mkNN Connectivity Matrix
            scatter(points(:,1), points(:,2));
            [G] = mkNNConGraph(points,10);
            
            if not(isConnected(G))
                fprintf('The graph is not connected.\n'); 
            end
            
            [S] = chooseSimFun(points);
            W = sparse(S .* G);
            spy(W)
%             if (det(W) ~= 0)
            x_spec = plotter(W, K, points);
%             end
            
        elseif connGraph == 4 % CNN Connectivity Matrix
            % TODO
            fprintf('To be done\n');
            
        else
            fprintf('You have to choose a number from 1 to 4\n');
            continue;
        end
        
        done = true;
    end
end