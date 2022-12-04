function PlotRegressionResults(X,actual,predicted,figN,titleString)
    if (size(X,2) == 1) %2D plot
        fh(figN) = figure(figN);
        clf(fh(figN))
        actualMarker = 'o';
        predictedMarker = 'x';
        plot(X,actual,actualMarker,'MarkerSize',5)
        hold on
        plot(X,predicted,predictedMarker,'MarkerSize',5)
        hold on
        title(titleString)
        legend("Actual","Predicted")
        grid on
        hold off
    end
    if (size(X,2) == 2) %3D plot
        fh(figN) = figure(figN);
        clf(fh(figN))
        actualMarker = 'o';
        predictedMarker = 'x';
        plot3(X(:,1),X(:,2),actual,actualMarker,'MarkerSize',5)
        hold on
        plot3(X(:,1),X(:,2),predicted,predictedMarker,'MarkerSize',5)
        hold on
        title(titleString)
        legend("Actual","Predicted")
        grid on
        hold off
    end
end