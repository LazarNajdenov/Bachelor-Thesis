function [V, lambda] = chooseLapl(W, K, laplMat)
% CLUSTERROWS function that computes the laplacian matrix
% L which can be, depending on the input given:
%   - unnormalized, if input = 1 
%   - symmetric normalized, if input = 2
%   - random-walk Laplacian, if input = 3
% and compute the relative K smallest magnitude eigenvectors
% 
% Input
% W      : Adjacency matrix
% K      : Number of clusters
% Output
% L      : Laplacian matrix
% V      : K smallest eigenvectors
% P      : Transition probability matrix(Diffusion matrix)

%     if nargout > 2,      P = zeros(size(W)); end
    % Unnormalized Laplacian
    if laplMat == 1,     [V, lambda] = unnormLapl(W, K);
    % Symmetric Normalized Laplacian
    elseif laplMat == 2, [V, lambda] = symmLapl(W, K);
    % Random-Walk Laplacian
    elseif laplMat == 3, [V, lambda] = randwalkLapl(W, K);
    end
    
end