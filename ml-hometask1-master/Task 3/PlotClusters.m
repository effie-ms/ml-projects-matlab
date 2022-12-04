function PlotClusters(X,figN,labels,titleString)
    k = length(unique(labels));
    fh(figN) = figure(figN);
    clf(fh(figN))
    colors = hsv(k);
    j = 1;
    if any(labels == 0)
        j = j+1;
    end
    for i = 1:k
        j = j+1;
    end
    for i=1:size(X,1)
        m = '.';
        if labels(i) == 0
            m = 'x';
        end
        plot(X(i,1),X(i,2),m,'MarkerSize',10,'Color',colors(labels(i)+1,:))
        hold on
    end
    title(titleString)
    grid on
end