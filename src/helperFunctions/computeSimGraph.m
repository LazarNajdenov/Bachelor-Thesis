function [W] = computeSimGraph(Pts, simGraph)
%COMPUTESIMGRAPH compute the adjacency matrix for the given points based on 
% the similarity graph configuration:

    if simGraph == 1 % kNN-Max
        kNN = input('Choose the number of kNN\n');
        G = kNNConGraph(Pts, kNN);
        if ~isConnected(G), error('The graph is not connected'); end
        S = maxSimilarityfunc(Pts, kNN);
        
    elseif simGraph == 2 % kNN-Gauss
        kNN = input('Choose the number of kNN\n');
        G = kNNConGraph(Pts, kNN);
        if ~isConnected(G), error('The graph is not connected'); end
        S = gaussSimilarityfunc(Pts);
        
    elseif simGraph == 3 % kNN-Local
        kNN = input('Choose the number of kNN\n');
        G = kNNConGraph(Pts, kNN);
        if ~isConnected(G), error('The graph is not connected'); end
        S = scaledGaussSimilarityfunc(Pts, kNN);
        
    elseif simGraph == 4 % eps-Gauss
        epsilon = heurEps3(Pts);
        G = USI_epsilonConGraph(epsilon, Pts);
        if ~isConnected(G), error('The graph is not connected'); end
        S = gaussSimilarityfunc(Pts);
        
    elseif simGraph == 5 % eps-CNN
        epsilon = heurEps3(Pts);
        G = USI_epsilonConGraph(epsilon, Pts);
        if ~isConnected(G), error('The graph is not connected'); end
        S = commonNearNeighborSimilarityFunc(Pts, epsilon);
        
    elseif simGraph == 6 % mkNN-Max
        mkNN = input('Choose the number of mkNN\n');
        G = mkNNConGraph(Pts, mkNN);
        if ~isConnected(G), error('The graph is not connected'); end
        S = scaledGaussSimilarityfunc(Pts, mkNN);
        
    elseif simGraph == 7 % mkNN-Gauss
        mkNN = input('Choose the number of mkNN\n');
        G = mkNNConGraph(Pts, mkNN);
        if ~isConnected(G), error('The graph is not connected'); end
        S = scaledGaussSimilarityfunc(Pts, mkNN);
        
    else % mkNN-Local
        mkNN = input('Choose the number of mkNN\n');
        G = mkNNConGraph(Pts, mkNN);
        if ~isConnected(G), error('The graph is not connected'); end
        S = scaledGaussSimilarityfunc(Pts, mkNN);
    end
    
    W = sparse(S .* G);
end

