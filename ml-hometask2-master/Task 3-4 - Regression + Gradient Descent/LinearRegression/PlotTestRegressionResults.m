function PlotTestRegressionResults(X,actual,coeffs,figN,titleString,coeffMethods)
    if (size(X,2) == 1) %2D plot
        fh(figN) = figure(figN);
        clf(fh(figN))
        actualMarker = 'o';
        predictedMarker = '-';
        plot(X,actual,actualMarker,'MarkerSize',5)
        hold on
        for i = 1:length(coeffMethods)
            b = coeffs(:,i);
            predicted = X' * b(2:end) + b(1);
            plot(X,predicted,predictedMarker,'MarkerSize',5)
            hold on
        end
        title(titleString)
        legend("Actual","OLS","BGD","SGD")
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
        for i = 1:length(coeffMethods)
            b = coeffs(:,i);
            predicted = sum(X' .* b(2:end)) + b(1);
            plot3(X(:,1),X(:,2),predicted',predictedMarker,'MarkerSize',5)
            hold on
        end
        title(titleString)
        legend("Actual","OLS","BGD","SGD")
        grid on
        hold off
    end
end