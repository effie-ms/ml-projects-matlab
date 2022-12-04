clear 
clc
close all

%% Load data
data = load('XR1');
XY = data.XR1;
% data = load('XR2');
% XY = data.XR2;

%% Prepare data
%XY = NormalizeDataset(XY);

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
    [predicted,actual,testX,b] = EvaluateMyLinearRegression(XY, kFolds, learningRate, n, coeffMethod);
    PerformanceReportRegression(testX,actual,predicted);
    coeffs = [coeffs, b];
end

PlotTestRegressionResults(testX,actual,coeffs,2,'Linear Regression',coeffMethods)

%PlotRegressionResults(testX,actual,predicted,2,'Linear Regression')