function [L, V, x_spec, P] = clusterRows(W, K, laplMat)
% CLUSTERROWS function that clusters rows of eigenvector matrix of the laplacian matrix
% L which can be, depending on the input given:
%   - unnormalized, if input = 1 
%   - symmetric normalized, if input = 2
%   - random-walk Laplacian, if input = 3
% and compute the relative K smallest magnitude eigenvectors
% 
% Input
% W    : Adjacency matrix
% K    : Number of clusters
% Output
% L    : Laplacian
% V    : K smallest eigenvectors

    % Degree matrix
    Diag = zeros(size(W,1));
    for i = 1:size(W,1)
       Diag(i,i) = sum(W(:,i)); 
    end
    
    % Construct the unnormalized Laplacian
    L = Diag - W;
    
    if laplMat == 1 % Unnormalized Laplacian
        
        [V,~] = eigs(L, K, 'SA'); 
        x_spec = kmeans(V, K,'Display', 'final','Replicates', 10);

    elseif laplMat == 2 % Symmetric Normalized Laplacian
        
        d        = diag(1./sqrt(Diag));
        DiagHalf = Diag + diag(d - diag(Diag));
        L        = DiagHalf * L * DiagHalf;
        [V,~]    = eigs(L, K, 'SA'); 
        x_spec   = kmeans(V, K,'Display', 'final','Replicates', 10);

    elseif laplMat == 3 % Random-Walk Laplacian
        beta   = 1;
        n      = size(W,1);
        I      = speye(n);
        P      = Diag^(-beta) * W;
        L      = I - Diag^(-beta) * W;
        [V,~]  = eigs(L, K, 'SA');
        x_spec = kmeans(V, K,'Display', 'final','Replicates', 10);
        
    else
        error('Please choose a number from 1 to 3');
    end
end