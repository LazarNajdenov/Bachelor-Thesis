function [] = plotter(W, K, Pts)
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
    % Plot Adjacency Matrix     
    figure(1)
    gplotg(W,Pts(:,1:2));
    title('Adjacency matrix')
   
    % Plot Weight of the edge distribution
    figure(2)
    wgPlot(W, Pts, 'edgeColorMap',jet,'edgeWidth',2);
    title('Weight Distribution')
    
    % Graph Laplacian creation     
    [L,~] = CreateLapl(W);
    
    % \----------------------------/
    % EigenVector Computation
    [V,~] = eigs(L, K, 'smallestabs'); 
    % \----------------------------/

    % EigenVector plot
    % figure(3)
    % plot(W,V(:,[2,3]));
    % xlabel('Eigenvector coordinates')

    % Cluster rows of eigenvector matrix of L corresponding to K smallest
    % eigenvalues. Use kmeans for that.
    [~,x_spec] = kmeans_mod(V,K,n);
    figure(3)
    gplotmap(W,Pts,x_spec)
    title('Spectral clustering result')

end