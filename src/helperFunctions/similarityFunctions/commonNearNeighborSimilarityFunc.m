function [S] = commonNearNeighborSimilarityFunc(Pts, epsilon)
% COMMONNEARNEIGHBORSIMILARITYFUNC create similarity matrix S, based on 
% local density adaptive similarity measure

    n = length(Pts(:,1));
    sigma = 2*log(n);

    fprintf('----------------------------------------\n');
    fprintf('Common Near Neighbor similarity function\n');
    fprintf('----------------------------------------\n');
    
    % Compute Euclidean Distance between points     
    S = squareform(pdist(Pts));
    % Compute Common Near Neighbor similarity function    
    S = exp(-S.^2 ./ (2*sigma^2 .* (computeCNN(S, epsilon) + 1)));
end