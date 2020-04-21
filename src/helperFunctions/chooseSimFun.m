function S = chooseSimFun(Pts, simFun)
% CHOOSESIMFUN an helper function that chooses which similarity function 
% to use, and return the relative Similarity Matrix
%
% Input
% Pts:    matrix containing data points features
% simFun: input value deciding which similarity function to use
%       - 1: Gaussian Similarity Function
%       - 2: Max Gaussian Similarity Function
%       - 3: Extended Gaussian Similarity Function
%       - 4: CNN similarity measure
% Output:
% S:      similarity matrix
    
    % Gaussian Similarity Matrix
    if     simFun == 1, S = gaussSimilarityfunc(Pts);
    % Max Similarity Matrix
    elseif simFun == 2, S = maxSimilarityfunc(Pts,10);
    % Extended Gaussian Similarity Matrix
    elseif simFun == 3, S = scaledGaussSimilarityfunc(Pts,10);
    % elseif sim == 4 % CNN Similarity Matrix
    % S = commonNearNeighborSimilarityFunc(Pts, epsilon);
    else,  error('Please choose a number from 1 to 3');
    end
        
end