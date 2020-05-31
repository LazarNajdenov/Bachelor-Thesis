function [G] = USI_epsilonConGraph(epsilon,Pts)
% Construct an epsilon connectivity graph
% Input
% epsilon: size of neighborhood (calculate from Prim's Algorithm) 
% Pts    : coordinate list of the sample 
% 
% Output
% A      : the epsilon connectivity matrix
% 
% USI, ICS, Lugano
% Numerical Computing

fprintf('----------------------------\n');
fprintf('epsilon similarity graph\n');
fprintf('----------------------------\n');

n = length(Pts(:,1));
G = zeros(n,n);
for i = 1:n
    for j = 1:n
        dist = norm(Pts(i,:) - Pts(j,:));
        if dist < epsilon
            G(i,j) = 1;
            G(j,i) = 1;
        end
    end
end


end
