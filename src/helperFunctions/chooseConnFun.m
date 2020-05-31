function [G, kNN] = chooseConnFun(Pts, connFun)
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
    if nargout > 1
        kNN = 0;
    end
    % Epsilon-neighborhood Connectivity Matrix
    if     connFun == 1, epsilon = heurEps3(Pts);
                         G = USI_epsilonConGraph(epsilon,Pts);
    % kNN Connectivity Matrix
    elseif connFun == 2, kNN = input('Choose the number of kNN\n');
                         G = kNNConGraph(Pts,kNN);
    % mkNN Connectivity Matrix
    elseif connFun == 3, kNN = input('Choose the number of mkNN\n');
                         G = mkNNConGraph(Pts,kNN);
    end
end