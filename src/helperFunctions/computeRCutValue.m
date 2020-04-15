function [RCut,RCCut] = computeRCutValue(clusters,W,normalized)
% Computes the components in the Ratio/Normalized Cut and Ratio/Normalized Cheeger Cut expression.
%
% Usage: [RCut,RCCut] = computeCutValue(clusters,W,normalized)

K     = max(clusters);
RCut  = 0;
RCCut = 0;

for k = 1:K
    
    W2  = W(clusters==k,clusters~=k);
    cut = full(sum(sum(W2)));
    
    
    if (~normalized)
        cardinalityA = sum(clusters==k);
        cardinalityB = sum(clusters~=k);
        
        cutpart = cut/cardinalityA;
        cutpart_min = cut/min(cardinalityA,cardinalityB);
    else
        degreeA = sum(W(:,clusters==k));
        degreeB = sum(W(:,clusters~=k));
        
        volA   = sum(degreeA);
        volB   = sum(degreeB);
        
        cutpart = cut/volA;
        cutpart_min = cut/min(volA,volB);       
    end
    RCut  = RCut  + cutpart; 
    RCCut = RCCut + cutpart_min;  
end

end