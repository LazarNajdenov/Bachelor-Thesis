% Generate adjacencies matrices for OPENML datasets

case_name = 'robot';

file_name = strcat(case_name,'_all.mat');

load(file_name);

data_labels   = table2array(eval(strcat(case_name,'_labels')));

unique_labels = unique(data_labels);
num_labels    = size(unique_labels,1);

Data          = eval(strcat(case_name,'_data'));
n             = size(Data,1);
label         = zeros(n,1);

for i = 1:n
    label(i)  = find(unique_labels == data_labels(i))-1; %0 based labels
end

Data          = double(Data);

kNN           = 10;

mat_name      = strcat(case_name);
mat_name      = strcat(mat_name,'_',num2str(kNN),'NN.mat');

% Helper function for generating Similarity Matrix, Connectivity Matrix,
% Adjacency matrix and spectral clustering results
[W, S, G, x_spec]  = benchmarkingScript(Data,4);

nonzero       = nnz(W);
nrows         = size(W,1);
fprintf("Adjacency generated : nrows = %d, nnz = %d, nnzr = %d\n",...
    nrows, nonzero, nonzero/nrows);

if(~strcmp(mat_name, "NULL"))
    save(mat_name,'W','label','x_spec')
end






