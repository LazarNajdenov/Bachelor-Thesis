function [avgAccU, avgAccS, avgAccR] = computeAvgAcc(n,K)
% COMPUTEAVGACC Computes the average accuracies on the three different Laplacians
% constructed from an adjacency matrix with the kNN, for a particular
% dataset

    % Retrieve the datapoints and the labels for the given dataset
    data = three_kernels(n);
    Pts  = data(:, 1:3);
    data_labels = data(:, 3);
    % Use kNN as connectivity function and Max Gauss assimilarity function 
    % to generate adjacency matrix
    [G, kNN] = chooseConnFun(Pts, 2);
    if ~isConnected(G), error('The graph is not connected'); end
    S = chooseSimFun(Pts, 2, kNN);
    W = sparse(S .* G);
    % Compute unnormalized Laplacian     
    [~, V1, ~] = chooseLapl(W, K, 1);
    % Compute symmetric normalized Laplacian
    [~, V2, ~] = chooseLapl(W, K, 2);
    % Compute normalized Random-walk Laplacian
    [~, V3, ~] = chooseLapl(W, K, 3);
    % Compute average accuracies for 10 runs of k-means     
    [~, ~, avgAccU, ~] = computeAccCutModul(W, V1, K, data_labels, 1);
    [~, ~, avgAccS, ~] = computeAccCutModul(W, V2, K, data_labels, 2);
    [~, ~, avgAccR, ~] = computeAccCutModul(W, V3, K, data_labels, 3);
    
end

