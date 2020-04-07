function plotter(W, Pts, L, V, x_spec)
% An helper function that plots:
%   - the Laplacian matrix,
%   - the eigenvector representation of the graph taken from the Laplacian,
%   - the spectral clustering results
% 
% INPUT:
%   - Adjacency matrix W
%   - Coordinates of the dataset Pts
%   - Laplacian Matrix L
%   - K smallest eigenvector V
    
    % Laplacian Matrix visualization
    figure(1);
    spy(L);
    
    % EigenVector coordinates plot
    figure(2);
    gplot(W, V(:,2:3));
    title('Eigenvector coordinates')
    
    % Clustering results plot
    figure(3);
    gplotmap(W,Pts,x_spec)
    title('Spectral clustering result')

end