function [avgAcc1, avgAcc2, avgAcc3, avgRatio1, avgRatio2, avgRatio3] = computeAvgAccRatio(n)
% COMPUTEAVGACCRATIO Computes the average accuracies and ratios on 
% three different graph construction for 3 kernels dataset
    warning off    
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
    
    % Compute Epsilon connectivity with Gaussian similarity
    epsilon = heurEps3(Pts);
    G1 = USI_epsilonSimGraph(epsilon, Pts);
    if ~isConnected(G1), error('The graph is not connected'); end
    S1 = gaussSimilarityfunc(Pts);
    W1 = sparse(S1 .* G1); 
    % Use kNN as connectivity function and Max Gauss assimilarity function 
    % to generate adjacency matrix
    G2 = kNNConGraph(Pts, 20);
    if ~isConnected(G2), error('The graph is not connected'); end
    S2 = maxSimilarityfunc(Pts, 20);
    W2 = sparse(S2 .* G2);
    % Compute CNN
    S3 = commonNearNeighborSimilarityFunc(Pts, epsilon);
    W3 = sparse(S3 .* G1);
    
    % Compute unnormalized Laplacian     
    [V1, ~] = chooseLapl(W1, K, 1);
    % Compute symmetric normalized Laplacian
    [V2, ~] = chooseLapl(W2, K, 1);
    % Compute normalized Random-walk Laplacian
    [V3, ~] = chooseLapl(W3, K, 1);
    % Compute average accuracies for 10 runs of k-means     
    [~, ~, avgAcc1, avgRatio1, ~] = computeAccCutModul(W1, V1, K, label);
    [~, ~, avgAcc2, avgRatio2, ~] = computeAccCutModul(W2, V2, K, label);
    [~, ~, avgAcc3, avgRatio3, ~] = computeAccCutModul(W3, V3, K, label);
    
end


