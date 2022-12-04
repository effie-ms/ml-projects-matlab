clear 
clc
close all

%% Load data
data = load('XC2');
XY = data.XC2;

%% Prepare data
%XY(:,1:(size(XY,2)-1)) = NormalizeDataset(XY(:,1:(size(XY,2)-1)));
firstClassIndices = find(XY(:,size(XY,2)) == 1);
secondClassIndices = find(XY(:,size(XY,2)) == 2);
XY(firstClassIndices,size(XY,2)) = 0;
XY(secondClassIndices,size(XY,2)) = 1;

%% Modeling
% Cross-validation parameters
kFolds = 10;

% Gradient descent parameters
learningRate = 0.1;
n = 100; % number of batches or epoches

coeffMethods = ["OLS","BGD","SGD"];
coeffs = [];

for i = 1:length(coeffMethods)
    coeffMethod = coeffMethods(i);%% Get predictions
    disp(strcat("Method: ", coeffMethod))
    %% Get predictions
    [predicted,actual,testX,b] = EvaluateMyLogisticRegression(XY, kFolds, learningRate, n, coeffMethod);
    stats = PerformanceReportClassification(actual,predicted);
    disp(stats)
    disp(stats.ConfusionMatrix)
    coeffs = [coeffs, b];
    PlotClasses(testX,actual,predicted,i,strcat("Logistic Regression: ",coeffMethod));
end

