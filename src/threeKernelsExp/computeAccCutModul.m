function [accuracy, cuts, meanAcc, meanCuts, x_results] = computeAccCutModul(W, V, K, label, laplMat)
% COMPUTEACCCUTMODUL compute accuracy, cuts, and modularity of
% different clustering results which depend on 1-10 k-means replicates
    x_results       = zeros(size(W, 1), 10);
    x_inferred      = zeros(size(W, 1), 10);
    accuracy        = zeros(10,1);
    cuts            = zeros(10,1);
%   modularity      = zeros(10,1);
    for i = 1 : 10
        x_results(:,i)                           = kmeans(V, K);
        x_inferred(:, i)                         = label_data(x_results(:,i), label);
        [~, accuracy(i), cuts(i), ~] = evaluate_clusters(label, x_inferred(:,i), ...
                                                   x_results(:,i), W, 0, 0, laplMat);
    end
    meanAcc = mean(accuracy);
    meanCuts = mean(cuts);
    
end
