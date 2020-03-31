function [x_spec] = plotter(W, K, Pts)
% An helper function that plots:
%   - the adjacency matrix W
%   - the eigenvector representation of the graph taken from the Laplacian,  
%   - the weighted graph from the adjacency matrix and vertices coordinate, 
%   - the spectral clustering results
% 
% INPUT:
%   - Adjacency matrix W
%   - Number of clusters K
%   - Coordinates of the dataset Pts
% 

    n = size(Pts,1);
%       % Plot Adjacency Matrix     
%     figure(1)
%     gplotg(W,Pts(:,1:2));
%     title('Adjacency matrix')
%    
%       % Plot Weight of the edge distribution
%     figure(2)
%     wgPlot(W, Pts, 'edgeColorMap',jet,'edgeWidth',2);
%     title('Weight Distribution')
    
%     % Graph Laplacian creation     
    [L,~] = CreateLapl(W);

 
%     % EigenVector Computation wih eigs
%     [V,~] = eigs(L, K, 'SA'); 


%   % Eigenvector computation with eig   
%   % Compute diagonal matrix D of eigenvalues and matrix Vss whose columns 
%   % are the corresponding right eigenvectors  
    [Vss,D] = eig(L);
%   % Sort the Eigenvalues in ascending order by magnitude
    [~,ind] = sort(diag(D), 'ComparisonMethod','abs');
%   % Rearrange the eigenvector corresponding to their eigenvalues  
    Vs = Vss(:,ind);
%   % Take the first K eigenvectors corresponding to the K smallest eigenvalues  
    V = Vs(:,1:K);
      

%     % EigenVector and nodal plot
%     figure(1)
%     subplot(1,2,1)
%     gplot(W, Pts);
%     xlabel('Nodal coordinates')
%     subplot(1,2,2)
%     gplot(W, V(:,1:K));
%     xlabel('Eigenvector coordinates')

%     % Cluster rows of eigenvector matrix of L corresponding to K smallest
%     % eigenvalues. Use kmeans for that.
    [~,x_spec] = kmeans_mod(V,K,n);
    figure(2)
    gplotmap(W,Pts,x_spec)
    title('Spectral clustering result')

end