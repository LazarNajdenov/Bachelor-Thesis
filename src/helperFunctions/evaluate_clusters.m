function [Confusion, ACC, RCut, NCut, Q] = evaluate_clusters(labels,inferred_labels,clusters,W,...
                                printflag, blackBox)

    n = length(labels);

    % CREATE CONFUSION MATRIX
    [Confusion] = confusionmat(labels,inferred_labels);

    % CALCULATE ERRORS
    diff = (labels - inferred_labels);
    hits = length(find(diff==0));
    ACC  = hits/n;


    %  Compute Ratio Cut, Normalized Cut, and Modularity
    if ~blackBox
        [RCut, NCut] = computeRCutValue(clusters,W);
        [Q] = QFModul(clusters, W);
    end


    if printflag==1
        fprintf('---------------------\n');
        fprintf('Confusion Matrix\n'); 
        fmt = [repmat('%4d ', 1, size(Confusion,2)-1), '%4d\n'];
        fprintf(fmt, Confusion.');
        fprintf('---------------------\n');
        if ~blackBox
            fprintf('ACC = %f, RCut = %f, NCut = %f, MOD = %f\n', ACC, RCut, NCut, Q);
        else 
            fprintf('ACC = %f\n', ACC);
        end
    end

end
