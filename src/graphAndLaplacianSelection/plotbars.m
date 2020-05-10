function plotbars(mAcc1, mRatio1, mAcc2, mRatio2, mAcc3, mRatio3)
%PLOTBARS Helper function for plotting through bars the correlation between
% the accuracy and the cuts.
    img = figure;
    y = [mAcc1, mRatio1; mAcc2, mRatio2; mAcc3, mRatio3];
    x = categorical({'Eps-Gauss','kNN-Max', 'Eps-Cnn'});
    x = reordercats(x,{'Eps-Gauss','kNN-Max', 'Eps-Cnn'});
    b = bar(x,y);
    lgd = legend('Accuracy', 'Ratio','Location','BestOutside');
    lgd.FontSize = 15;
    lgd.Title.String = 'Legend BarPlot';
    limit = max(max(y(:,1)),max(y(:,2)));
    ylim([0 limit+5]);
    xtips1 = b(1).XEndPoints;
    ytips1 = b(1).YEndPoints;
    labels1 = string(b(1).YData);
    text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom', 'FontSize', 12)
    xtips2 = b(2).XEndPoints;
    ytips2 = b(2).YEndPoints;
    labels2 = string(b(2).YData);
    text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom','FontSize', 12)
    set(gca,'fontsize',15)
    set(img,'Renderer', 'painters', 'Position', [400 150 950 600])
end

