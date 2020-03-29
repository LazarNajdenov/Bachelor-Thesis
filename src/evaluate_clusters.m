function [Confusion,ACC,RCut,RCCut] = evaluate_clusters(labels,inferred_labels,clusters,W,printflag)

normalized = false;

n = length(labels);

% CREATE CONFUSION MATRIX
[Confusion] = confusionmat(labels,inferred_labels);

% CALCULATE ERRORS
diff = (labels - inferred_labels);
hits = length(find(diff==0));
ACC  = hits/n;


%  Ratio Cut and Ratio Cheeger Cut
[RCut,RCCut] = computeRCutValue(clusters,W,normalized);


if printflag==1
   fprintf('---------------------\n');
   fprintf('Confusion Matrix\n'); 
   fmt = [repmat('%4d ', 1, size(Confusion,2)-1), '%4d\n'];
   fprintf(fmt, Confusion.');
   fprintf('---------------------\n');

   fprintf('ACC = %f, RCut = %f, RCCut = %f\n', ACC,RCut, RCCut);      
end

end