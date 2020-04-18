function [RCut] = computeRCutValue(clusters,W,normalized)
% Computes the components in the Ratio/Normalized Cut expression.
%
% Usage: [RCut,RCCut] = computeCutValue(clusters,W,normalized)

    K     = max(clusters);
    RCut  = 0;

    for k = 1:K

        W2  = W(clusters==k,clusters~=k);
        cut = full(sum(sum(W2)));

        if (normalized == 1)
            cardinalityA = sum(clusters==k);
            cutpart = cut/cardinalityA;
        else
            degreeA = sum(W(:,clusters==k));
            volA   = sum(degreeA);
            cutpart = cut/volA;
        end
        RCut  = RCut  + cutpart; 
    end

end