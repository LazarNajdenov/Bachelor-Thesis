function [cnn] = computeCNN(S,epsilon)
% COMPUTECNN computes the number of common near neighbors(cnn) between 
%            every data point of the dataset.
% 
% Input
% S:       matrix containing all the euclidean distances between every pair
% epsilon: radius of the epsilon-neighorhood
% Output
% cnn: matrix with the number of cnn between every pair of data

    cnn = zeros(size(S));
    n = size(S,1);
    f = waitbar(0,'1','Name','Compute Cnn similarity - maxima enim, patientia virtus',...
    'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    for i = 1 : n
        % Find the indices of all the elements within radius epsilon of 
        % point i    
        a = find(S(i,:) <= epsilon);
        for j = i + 1 : n
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
        waitbar(i/n,f,sprintf('%5.2f',100*i/n))
    end
    delete(f)
end

