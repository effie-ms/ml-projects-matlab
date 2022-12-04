function rmse = MyRMSE(actual,predicted)
    predictionError = sum((predicted - actual).^2);
    rmse = sqrt(predictionError / length(actual));
end
