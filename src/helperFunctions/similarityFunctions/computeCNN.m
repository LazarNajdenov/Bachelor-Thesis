function [cnn] = computeCNN(S,epsilon)
% COMPUTECNN : computes the number of common near neighbors between every
% data point of the dataset
% cnn = computeCNN(S, epsilon) returns a matrix with the number of cnn
%     between every pair of data
    cnn = zeros(size(S));
    n = size(S,1);
    for i = 1 : n
        for j = i + 1 : n
            % Find the indices of all the elements within radius epsilon of 
            % point i            
            a = find(S(i,:) <= epsilon);
            % Find the indices of all the elements within radius epsilon of
            % point j
            b = find(S(j,:) <= epsilon);
            % Create logical array with the maximum index/value 
            % between a and b
            logArr = zeros(max(max(a), max(b)), 1);
            logArr(a) = 1;
            % Pick out the elements of "b" that are in "a" through 
            % the logical array.
            c = b(logical(logArr(b)));
            % c = intersect(a,b);
            cnn(i,j) = length(c); 
            cnn(j,i) = cnn(i,j);
        end
    end
end

