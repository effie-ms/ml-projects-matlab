function [yhat,b,b0] = PredictLinearRegression(X,y)
    [b,b0] = GetCoefficientsOrdinaryLeastSquares(X,y);
    [nX,dX] = size(X);
    yhat = zeros(nX,1);
    for i = 1:nX
        yhat(i) = b0 + sum(b'.* X(i,:));
    end
end

function [b,b0] = GetCoefficientsOrdinaryLeastSquares(X,y)
    X = [ones(length(y),1), X];
    coef = inv(X'*X)*X'*y;
    b0 = coef(1);
    b = coef(2:end);
end

