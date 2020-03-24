function [x_inferred, inferred_label] = label_data(x,labels)
% Input:
%       x: clustering result
%       labels: true labelling
% Output
%       x_inferred: the interpreted solution according to the labels 
% 


% determine # of clusters
if min(x) == 0
    K = max(x)+1;
else
    K = max(x);
    %    x = x-1;
end

inferred_label = -1*ones(K,1);

x_inferred = x;

for k=1:K
    index        = find(x==k);
    cur_labels   = labels(index);
    actual_label = mode(cur_labels);
    inferred_label(k)= actual_label;
    x_inferred(index) = actual_label;
end


end