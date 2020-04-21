function [G] = chooseConnFun(Pts, connFun)
% CHOOSECONNFUN an helper function that takes the coordinate list from a 
% dataset and, they type of connectivity function we want to generate, 
% and gives us back the connectivity matrix.
% 
% Input:
% Pts:     matrix containing data points features
% connFun: input value deciding which connectivity function to use
%          - 1 -> epsilon-similarity-graph
%          - 2 -> k-nearest-neighbor (kNN)
%          - 3 -> mutual k-nearest-neighbor (mkNN)
% Output:
% G:      connectivity matrix

    % Epsilon-neighborhood Connectivity Matrix
    if     connFun == 1, epsilon = heurEps3(Pts);
                         G = USI_epsilonSimGraph(epsilon,Pts);
    % kNN Connectivity Matrix
    elseif connFun == 2, G = kNNConGraph(Pts,10);
    % mkNN Connectivity Matrix
    elseif connFun == 3, G = mkNNConGraph(Pts,10);
    end
end