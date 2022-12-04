function stats = PerformanceReportRegression(X,actual,predicted)
    p = size(X,2);
    n = size(X,1);
    [RSquared, AdjustedRSquared] = MyDeterminationCoefficients(actual,predicted,p);
    RMSE = MyRMSE(actual,predicted);
    RSS = MyRSS(actual,predicted);
%     f = MySignificanceFValue(actual,predicted,p,n);
%     pValue = 1-fcdf(f,p,n);
    stats = struct('RSquared',RSquared,'AdjustedRSquared',AdjustedRSquared,'RMSE',RMSE,'RSS',RSS);
    disp(stats)
end

function [RSquared,adjustedRSquared] = MyDeterminationCoefficients(y,yhat,p)
    n = length(y);
    RSS = MyRSS(y,yhat); % residual sum of squares
    totalSSR = sum((y-mean(y)).^2); % total sum of squares 
    RSquared = 1-RSS/totalSSR; % R squared 
    adjustedRSquared = 1 - RSS/totalSSR * (n-1)/(n-p);  % Adjusted (to the number of parameters) R squared  
end

function rss = MyRSS(actual,predicted)
    rss = sum((actual-predicted).^2);
end

function rmse = MyRMSE(actual,predicted)
    predictionError = sum((predicted - actual).^2);
    rmse = sqrt(predictionError / length(actual));
end

function f = MySignificanceFValue(y,yhat,p,n)
    nom= sum((yhat - mean(y)).^2) / (p-1);
    denom = sum((y - yhat).^2) / (n-p);
    f = nom / denom;
end
