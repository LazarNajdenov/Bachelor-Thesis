function epsilon = heurEps(points)
    tic
    % Compute Euclidean Distance between all pairs of data points 
    P = squareform(pdist(points));
    UpMatrix = P(triu(true(size(P)),1));
    nnz(UpMatrix);
    % Mean of distances between all pairs of data points
    mean_d = mean(UpMatrix);
    % Minimum distance between all pairs of data points
    min_d = min(UpMatrix);
    % Maximum distance between all pairs of data points
    max_d = max(UpMatrix);
    % Find nearest neighbor for each point through distancee
    P(P == 0) = inf;
    distNN = min(P, [], 2);
    % Maximum distance between each data point and its nearest neighbor
    max_n = max(distNN);
    % Mean of distances between each data point and its nearest neighbor
    mean_n = mean(distNN);
    % Heuristic of Epsilon value, for the epsilon similarity graph
    epsilon = 20 * mean_d + 54 * min_d + 13 * max_n - 6 * max_d - 65 * mean_n;
    
    timeElapsed = toc;
end

