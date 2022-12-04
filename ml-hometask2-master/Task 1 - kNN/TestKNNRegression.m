clear 
clc
close all

%% Regression test

problemType = 'regression';

%% Load data
% data = load('XR1');
% XY = data.XR1;
data = load('XR2');
XY = data.XR2;

%% Prepare data
X = XY;
labels = X(:,size(X,2));
X = X(:,1:(size(X,2)-1));
[nX,dX] = size(X);

%% Split data
split = 0.7;
rng(3);
trainIndices = (1:ceil(split * nX))';
testIndices = setdiff((1:nX)',trainIndices);
trainSet = [X(trainIndices,:) labels(trainIndices)];

testSet = X(testIndices,:);
actual = labels(testIndices);

%% Generate predictions
% k = 4;
% distFunction = 'euclidean';
% predicted = PredictKNN(trainSet,testSet,k,distFunction,problemType);
% rmse = MyRMSE(actual, predicted);
% PlotRegressionResults(testSet,actual,predicted,1,strcat("Regression kNN: k=", string(k), ", distance=", distFunction, ", RMSE= ", string(rmse)))

%% Test different k and distance functions

distanceFunctions = ["cityblock","euclidean","chebychev","canberra","cosine","mahalanobis"];
rmses = zeros(length(distanceFunctions),10);
      
for i = 1:length(distanceFunctions)
    distFunction = distanceFunctions(i);
    for k = 1:10
        predicted = PredictKNN(trainSet,testSet,k,distFunction,problemType);
        rmses(i,k) = MyRMSE(actual, predicted)
    end  
end
 
rmsesTable = [distanceFunctions' rmses];
rmsesTable = [["DistFunc\k", string(1:10)]; rmsesTable];
averageRMSEByDistFunction = mean(rmses,2);
averageRMSEByK = mean(rmses,1);
rmsesTable = [rmsesTable, ["Avg by DistFunc"; string(averageRMSEByDistFunction)]];
rmsesTable = [rmsesTable; ["Avg by k", string(averageRMSEByK), string(mean(averageRMSEByDistFunction))]];
[minAvgRMSEDistFunc, idxDistFunc] = min(averageRMSEByDistFunction);
[minAvgRMSEK, idxK] = min(averageRMSEByK);

disp(rmsesTable)
disp(strcat("Best distance functions for the dataset and kNN: ", distanceFunctions(idxDistFunc), " (average RMSE: ", string(minAvgRMSEDistFunc), ")"))
disp(strcat("Best K for the dataset and kNN: ", string(idxK), " (average RMSE: ", string(minAvgRMSEK), ")"))

figure;
for i = 1:size(rmses,1)
    plot(1:10,rmses(i,:),'LineWidth',2)
    hold on
    xlabel('k')
    ylabel('RMSE')
    legend(distanceFunctions)
    title("kNN performance with different hyperparameters")
    grid on
end
hold off

k = idxK;
distFunction = distanceFunctions(idxDistFunc);
predicted = PredictKNN(trainSet,testSet,k,distFunction,problemType);
rmse = MyRMSE(actual, predicted);
PlotRegressionResults(testSet,actual,predicted,2,strcat("Regression kNN: k=", string(k), ", distance=", distFunction, ", RMSE= ", string(rmse)))