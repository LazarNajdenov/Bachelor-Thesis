function [L, V, x_spec] = clusterRows(W, K)
% Function that clusters rows of eigenvector matrix of the laplacian matrix
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
% 

% Degree matrix
Diag = zeros(size(W,1));
for i = 1:size(W,1)
   Diag(i,i) = sum(W(:,i)); 
end

% Construct the unnormalized Laplacian
L = Diag - W;

n = size(W,1);

done = false;
while ~done
    
    laplacian = input('Choose the type of Laplacian matrix construction L \n');
    
    if laplacian     == 1 % Unnormalized Laplacian
        
        % Compute K smallest magnitude eigenvector
        [V,~]    = eigs(L, K, 'SA'); 
        
        % Cluster rows of eigenvector matrix of L 
        [~,x_spec] = kmeans_mod(V,K,n);
        
    elseif laplacian == 2 % Symmetric Normalized Laplacian
        
        % Construct symmetric normalized Laplacian matrix
        d        = diag(1./sqrt(Diag));
        DiagHalf = Diag + diag(d - diag(Diag));
        L        = DiagHalf * L * DiagHalf;
        % Compute K smallest magnitude eigenvector
        [V,~] = eigs(L, K, 'SA'); 
        
        % Cluster rows of eigenvector matrix of L
        [~,x_spec] = kmeans_mod(V,K,n);
        
    elseif laplacian == 3 % Random-Walk Laplacian
        
        % Construct random-walk laplacian
        [V,~]    = eigs(L, Diag, K, 'SA');
        
        % Cluster rows of eigenvector matrix of L
        [~,x_spec] = kmeans_mod(V,K,n);
        
    else
        fprintf('You have to choose a number from 1 to 3\n');
        continue;
    end
    done = true;
end



end