function [S] = extGaussSimilarityfunc(Pts,kNN)
% Create the similarity matrix S 
n = length(Pts(:,1));

Sigma = zeros(n,1);

fprintf('----------------------------\n');
fprintf('Gaussian similarity function\n');
fprintf('----------------------------\n');
S = squareform(pdist(Pts));

for i = 1:n
     [~,index] = sort(S(:,i));
     Sigma(i) = S(index(kNN),i);
end
Sigma_mat = repmat(Sigma,1,n);
Sigma_mat = max(Sigma_mat, Sigma_mat');
S = exp(-S.^2 ./ (2*(Sigma_mat * Sigma_mat')));

end