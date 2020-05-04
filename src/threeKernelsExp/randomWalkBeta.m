function [L_rw, V, P] = randomWalkBeta(W,K,beta)
% RANDWALKLAPL Compute random-walk Laplacian and K smallest eigenvectors
% depending on beta values
    fprintf('--------------------------------\n');
    fprintf('Random Walk Laplacian\n');
    fprintf('--------------------------------\n');
    % Degree matrix
    Diag = zeros(size(W,1));
    for i = 1:size(W,1)
       Diag(i,i) = sum(W(:,i)); 
    end
    
    % Construct Random-walk Laplacian     
    n      = size(W,1);
    I      = speye(n);
    P      = Diag^(-beta) * W;
    L_rw   = I - P;
    [V,~]  = eigs(L_rw, K, 'SA');
end
