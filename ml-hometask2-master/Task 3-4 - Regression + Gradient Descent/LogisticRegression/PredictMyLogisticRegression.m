function [predictions,b] = PredictMyLogisticRegression(trainSet,testSet,coeffMethod,learningRate, n)
    X = trainSet(:,1:(size(trainSet,2)-1));
    y = trainSet(:,size(trainSet,2));
    switch coeffMethod
        case "OLS"
            [b, b0] = GetCoefficientsOrdinaryLeastSquares(X, y);
        case "BGD"
            [b, b0] = GetCoefficientsBatchGradientDescent(X, y, learningRate, n);
        case "SGD"
            [b, b0] = GetCoefficientsStochasticGradientDescent(X, y, learningRate, n);
    end
    predictions = Predict(testSet,b,b0);
    predictions = round(predictions);
    b = [b0;b];
end

function [b,b0] = GetCoefficientsOrdinaryLeastSquares(X,y)  
    X = [ones(length(y),1), X];
    coef = inv(X'*X)*X'*y;
    b0 = coef(1);
    b = coef(2:end);
end

function [b,b0] = GetCoefficientsBatchGradientDescent(X, y, learningRate, nBatch)
    X = [ones(length(y),1), X];
    [nX,dX] = size(X);
    coef = zeros(dX,1);
    for batch = 1:nBatch
        yhat = Predict(X(:,2:end),coef(2:end),coef(1));
        error = yhat - y;
        coef = coef - (learningRate/nX)*X'*(error .* (yhat .* (1 - yhat)));
    end
    b0 = coef(1);
    b = coef(2:end);
end

function [b,b0] = GetCoefficientsStochasticGradientDescent(X, y, learningRate, nEpoch)
    X = [ones(length(y),1), X];
    [nX,dX] = size(X);
    coef = zeros(1,dX);
    for epoch = 1:nEpoch % number of passes
        for j = 1:nX
			yhat = Predict(X(j,2:end), coef(2:end)', coef(1));
			error = yhat - y(j);
            coef = coef - learningRate * error * (yhat .* (1 - yhat)) .* X(j,:);
        end
    end
    b0 = coef(1);
    b = coef(2:end);
    b = b';
end

function yhat = Predict(X, b, b0)
    [nX,dX] = size(X);
    yhat = zeros(nX,1);
    for i = 1:nX
        yhat(i) = b0 + sum(b .* X(i,:)');
        yhat(i) = 1.0 / (1.0 + exp(-yhat(i)));
    end
end
