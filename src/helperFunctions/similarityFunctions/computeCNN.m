function [cnn] = computeCNN(S,epsilon)
%COMPUTECNN Summary of this function goes here
%   Detailed explanation goes here
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

