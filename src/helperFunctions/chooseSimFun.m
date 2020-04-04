function S = chooseSimFun(Pts)
% An helper function that chooses which similarity function to use.
%
% INPUT:
%   - Requests user input through 'input' function in order to choose 
%   the similarity function to obtain the similarity matrix S:
%       - 1: Gaussian Similarity Function
%       - 2: Max Gaussian Similarity Function
%       - 3: Extended Gaussian Similarity Function
%       - 4: CNN similarity measure
% 
    done = false;
    while (~done)
        sim = input('Choose the similarity function you want to use\n');
        if sim == 1 % Gaussian Similarity Matrix
            S = gaussSimilarityfunc(Pts);
        elseif sim == 2 % Max Similarity Matrix
            S = maxSimilarityfunc(Pts,10);
        elseif sim == 3 % Extended Gaussian Similarity Matrix
            S = scaledGaussSimilarityfunc(Pts,10);
        elseif sim == 4 % CNN Similarity Matrix
            % TODO CNN  
            fprintf('To be done\n');
        else
            fprintf('Please choose a number from 1 to 4\n');
            continue;
        end
        done = true;
    end
end