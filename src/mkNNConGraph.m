function G = mkNNConGraph(Pts, kNN)
% Construct a Mutual k-nearest neighbors connectivity graph
% Input
% k      : # of neighbors
% Pts    : coordinate list of the sample 
% 
% Output
% G      : the mkNN similarity matrix

n  = length(Pts(:,1));
G = zeros(n);
% Create an array of arrays
nbrs = cell(n,1);
fprintf('mkNN similarity graph\n');
    for i = 1:n
        
        % Repeat the i-th point n-row-times         
        s = repmat(Pts(i,:),n,1);
        d = Pts - s;
        % e = diag(d*d');
        
        % Compute the distance between the i-th point and the others        
        e = sum(d.^2,2);
        
        % Sort the distances and for each distance there is the
        % corresponding index
        [~,ind] = sort(e);
        
        
        % Remove the ith-point for which we are searching the kNN         
        [index_remove] = find(ind == i);
        ind(index_remove) = [];
        
        % Take the first kNN of the i-th point
        nbrs{i} = ind(1:kNN);
    end
    for i = 1:n
        for j = 1:n
            if i ~= j
                % Check if i is among the k-nearest neighbors of j 
                % and j is among the k-nearest neighbors of i                 
                if (ismember(i,nbrs{j}) && ismember(j,nbrs{i}))
                    G(i,j) = 1;
                    G(j,i) = 1;
                end
            end
        end
    end
    
end