function [accuracy, cuts, modularity] = computeAccCutModulBeta(W, K, label, laplMat)
% COMPUTEACCCUTMODULBETA compute accuracy, cuts, and modularity of
% different clustering results which depend on different values of beta 
% ranging from 1 to 2 for constructing the Random-Walk Laplacian
    x_results       = zeros(size(W, 1), 11);
    x_inferred      = zeros(size(W, 1), 11);
    accuracy        = zeros(11,1);
    cuts            = zeros(11,1);
    modularity      = zeros(11,1);
    beta = 1;
    i = 1;
    while beta <= 2
        [~, V, ~] = randomWalkBeta(W, K, beta);
        x_results(:,i) = kmeans(V, K,'Display', 'final','Replicates', 10);
        x_inferred(:, i) = label_data(x_results(:,i), label);
        [~, accuracy(i), cuts(i), modularity(i)] = evaluate_clusters(label, x_inferred(:,i), ...
                                                   x_results(:,i), W, 0, 0, laplMat);
        beta = beta + 0.1;
        i = i + 1;
    end
end