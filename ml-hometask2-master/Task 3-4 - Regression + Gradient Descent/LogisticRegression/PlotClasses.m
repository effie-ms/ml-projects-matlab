function PlotClasses(X,actual,predicted,figN,titleString)
    k = length(unique(actual));
    fh(figN) = figure(figN);
    clf(fh(figN))
    colors = hsv(k);
    actualMarker = 'o';
    predictedMarker = 'x';
    for i=1:size(X,1)
        plot(X(i,1),X(i,2),actualMarker,'MarkerSize',10,'Color',colors(actual(i)+1,:))
        hold on
        plot(X(i,1),X(i,2),predictedMarker,'MarkerSize',10,'Color',colors(predicted(i)+1,:))      
        hold on
    end
    title(titleString)
    grid on
    hold off
end