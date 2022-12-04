clear 
clc
close all

%% Classification test

problemType = 'classification';

%% Load data
% data = load('XC1');
% XY = data.XC1;
% data = load('XC2');
% XY = data.XC2;
data = load('XC3');
XY = data.XC3;


X = XY(:,1:(size(XY,2)-1));
labels = XY(:,size(XY,2));

%% Prepare data
[nX,dX] = size(X);
X = NormalizeDataset(X);

%% Split data
split = 0.7;
rng(3);
trainIndices = randperm(nX, ceil(split * nX))';
testIndices = setdiff((1:nX)',trainIndices);
trainSet = [X(trainIndices,:) labels(trainIndices)];

testSet = X(testIndices,:);
actual = labels(testIndices);

%% Generate predictions
% k = 4;
% distFunction = 'euclidean';
% predicted = PredictKNN(trainSet,testSet,k,distFunction,problemType);
% accuracy = MyAccuracy(actual, predicted);
% PlotClasses(testSet,actual,predicted,1,strcat("Classification kNN: k=", string(k), ", distance=", distFunction, ", accuracy= ", string(accuracy)))

%% Test different k and distance functions

distanceFunctions = ["cityblock","euclidean","chebychev","canberra","cosine","mahalanobis"];
accuracies = zeros(length(distanceFunctions),10);
     
for i = 1:length(distanceFunctions)
    distFunction = distanceFunctions(i);
    for k = 1:10
        predicted = PredictKNN(trainSet,testSet,k,distFunction,problemType);
        accuracies(i,k) = MyAccuracy(actual, predicted)
    end  
end

accuranciesTable = [distanceFunctions' accuracies];
accuranciesTable = [["DistFunc\k", string(1:10)]; accuranciesTable];
averageAccuracyByDistFunction = mean(accuracies,2);
averageAccuracyByK = mean(accuracies,1);
accuranciesTable = [accuranciesTable, ["Avg by DistFunc"; string(averageAccuracyByDistFunction)]];
accuranciesTable = [accuranciesTable; ["Avg by k", string(averageAccuracyByK), string(mean(averageAccuracyByDistFunction))]];
[maxAvgAccuracyDistFunc, idxDistFunc] = max(averageAccuracyByDistFunction);
[maxAvgAccuracyK, idxK] = max(averageAccuracyByK);

disp(accuranciesTable)
disp(strcat("Best distance functions for the dataset and kNN: ", distanceFunctions(idxDistFunc), " (average accuracy: ", string(maxAvgAccuracyDistFunc), ")"))
disp(strcat("Best K for the dataset and kNN: ", string(idxK), " (average accuracy: ", string(maxAvgAccuracyK), ")"))

figure;
for i = 1:size(accuracies,1)
    plot(1:10,accuracies(i,:),'LineWidth',2)
    hold on
    xlabel('k')
    ylabel('Accuracy')
    legend(distanceFunctions)
    title("kNN performance with different hyperparameters")
    grid on
end
hold off

k = idxK;
distFunction = distanceFunctions(idxDistFunc);
predicted = PredictKNN(trainSet,testSet,k,distFunction,'classification');
accuracy = MyAccuracy(actual, predicted);
PlotClasses(testSet,actual,predicted,2,strcat("Classification kNN: k=", string(k), ", distance=", distFunction, ", accuracy= ", string(accuracy)))
