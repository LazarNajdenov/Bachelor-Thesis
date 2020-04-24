function S = chooseSimFun(Pts, simFun, kNN)
% CHOOSESIMFUN an helper function that chooses which similarity function 
% to use, and return the relative Similarity Matrix
%
% Input
% Pts:    matrix containing data points features
% simFun: input value deciding which similarity function to use
%       - 1: Gaussian Similarity Function
%       - 2: Max Gaussian Similarity Function
%       - 3: Extended Gaussian Similarity Function
% Output:
% S:      similarity matrix
    
    % Gaussian Similarity Matrix
    if     simFun == 1, S = gaussSimilarityfunc(Pts);
    % Max Similarity Matrix
    elseif simFun == 2, S = maxSimilarityfunc(Pts,kNN);
    % Extended Gaussian Similarity Matrix
    elseif simFun == 3, S = scaledGaussSimilarityfunc(Pts,kNN);
    end
        
end