function [S] = gaussSimilarityfunc(Pts)
% Create the similarity matrix S from the coordinate list of the input
% points
% dimosthenis.pasadakis@usi.ch
% ICS, USI.


% Choose \sigma ~ 2*log(n)
n = length(Pts(:,1));
sigma = 2*log(n);

fprintf('----------------------------\n');
fprintf('Gaussian similarity function\n');
fprintf('----------------------------\n');
S = squareform(pdist(Pts));
S = exp(-S.^2 ./ (2*sigma^2));

end