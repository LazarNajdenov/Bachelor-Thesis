function epsilon = heurEps3(Pts)
% HEUREPS3 Returns the heuristic value epsilon for the epsilon-neighborhood
% Input
% Pts: points of the dataset with respective features
% Output
% epsilon: the value for the epsilon-neighoborhood
    n = size(Pts,1);
    epsilon = log((log(log(n))));
end

