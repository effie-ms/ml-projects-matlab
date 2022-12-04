function rmse = MyRMSE(actual,predicted)
%RMSEMETRIC Calculate root mean squared error
    predictionError = sum((predicted - actual).^2);
    rmse = sqrt(predictionError / length(actual));
end
