function [AccU, AccS, AccR, AccB, RatioU, RatioS, RatioR, RatioB] = computeAccCutLapl(W, label)
% COMPUTEAVGACC Computes the average accuracies on the three different 
% Laplacians constructed from an adjacency matrix with the kNN connectivity
% function and the Max similarity function, for a particular dataset

    % Compute unique values of the labels with no repetition
    unique_labels = unique(label);
    % Compute the number of unique labels
    K = size(unique_labels,1);
    % Compute unnormalized Laplacian     
    [~, V1, ~] = chooseLapl(W, K, 1);
    % Compute symmetric normalized Laplacian
    [~, V2, ~] = chooseLapl(W, K, 2);
    % Compute normalized Random-walk Laplacian (beta = 1)
    [~, V3, ~] = chooseLapl(W, K, 3);
    % Compute normalized Random-walk Laplacian (beta = 1.4)
    [~, V4, ~] = randomWalkBeta(W, K, 1.4);
    
    % Compute accuracies and cuts for by computing 10 replicates of kmeans
    % for each Laplacian to help find a lower, local minimum:
    
    % Unnormalized Laplacian
    x_results1 = kmeans(V1, K, 'Replicates', 10);
    x_inferred1 = label_data(x_results1, label);
    [~, AccU, RatioU, ~] = evaluate_clusters(label, x_inferred1, x_results1, W, 0, 0, 1);

    % Symmetric Laplacian
    x_results2 = kmeans(V2, K,'Replicates', 10);
    x_inferred2 = label_data(x_results2, label);
    [~, AccS, RatioS, ~] = evaluate_clusters(label, x_inferred2, x_results2, W, 0, 0, 2);
    
    % Random Walk Laplacian beta = 1
    x_results3 = kmeans(V3, K, 'Replicates', 10);
    x_inferred3 = label_data(x_results3, label);
    [~, AccR, RatioR, ~] = evaluate_clusters(label, x_inferred3, x_results3, W, 0, 0, 3);

    
    % Random Walk Laplacian beta = 1.4
    x_results4 = kmeans(V4, K, 'Replicates', 10);
    x_inferred4 = label_data(x_results4, label);
    [~, AccB, RatioB, ~] = evaluate_clusters(label, x_inferred4, x_results4, W, 0, 0, 3);
    
end

