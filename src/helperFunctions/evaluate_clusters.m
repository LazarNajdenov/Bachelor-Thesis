function [Confusion,ACC,RCut] = evaluate_clusters(labels,inferred_labels,clusters,W,...
                                printflag, blackBox, normalized)

    n = length(labels);

    % CREATE CONFUSION MATRIX
    [Confusion] = confusionmat(labels,inferred_labels);

    % CALCULATE ERRORS
    diff = (labels - inferred_labels);
    hits = length(find(diff==0));
    ACC  = hits/n;


    %  Ratio Cut and Ratio Cheeger Cut
    if ~blackBox
        [RCut] = computeRCutValue(clusters,W,normalized);
    end


    if printflag==1
        fprintf('---------------------\n');
        fprintf('Confusion Matrix\n'); 
        fmt = [repmat('%4d ', 1, size(Confusion,2)-1), '%4d\n'];
        fprintf(fmt, Confusion.');
        fprintf('---------------------\n');
        if ~blackBox
            if normalized == 1
                fprintf('ACC = %f, RCut = %f\n', ACC,RCut);
            else 
                fprintf('ACC = %f, NCut = %f\n', ACC,RCut);
            end
        else 
            fprintf('ACC = %f\n', ACC);
        end
    end

end
