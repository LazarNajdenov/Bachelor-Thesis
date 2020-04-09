function [cnn] = computeCNN(S,epsilon)
% COMPUTECNN : computes the number of common near neighbors between every
% data point of the dataset
% cnn = computeCNN(S, epsilon) returns a matrix with the number of cnn
%     between every pair of data
    cnn = zeros(size(S));
    n = size(S,1);
    for i = 1 : n
        for j = i + 1 : n
            a = find(S(i,:) <= epsilon);
            b = find(S(j,:) <= epsilon);
            c = intersect(a,b);
            cnn(i,j) = length(c); 
            cnn(j,i) = cnn(i,j);
        end
    end
end

