function [avgAccU, avgAccS, avgAccR] = computeAvgAcc(n)
% COMPUTEAVGACC Computes the average accuracies on the three different Laplacians
% constructed from an adjacency matrix with the kNN, for a particular
% dataset

    % Retrieve the datapoints for the given dataset
    data = three_kernels(n);
    Pts  = data(:, 1:2);
    % Retrieve labels for the given dataset
    data_labels = data(:, 3);
    % Compute unique values of the labels with no repetition
    unique_labels = unique(data_labels);
    % Compute the number of unique labels
    K = size(unique_labels,1);
    Pts = double(Pts);
    m = size(Pts,1);
    label = zeros(m,1);
    % Returns the labels normalized(from 0 to m)
    for i = 1:m
        % Returns the index of the array unique_labels that matches the value i 
        % of the original data_label
        label(i)  = find(unique_labels == data_labels(i))-1; %0 based labels
    end
    
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
    [~, ~, avgAccU, ~] = computeAccCutModul(W, V1, K, label, 1);
    [~, ~, avgAccS, ~] = computeAccCutModul(W, V2, K, label, 2);
    [~, ~, avgAccR, ~] = computeAccCutModul(W, V3, K, label, 3);
    
end

