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
%XY = NormalizeDataset(XY);

%% Modeling
% Cross-validation parameters
kFolds = 10;
% Decision tree parameters
maxDepth = 5; % maximum depth of the tree
minSize = 10; % minimum number of instances in the node

%% Get predictions
[predicted,actual,testX] = EvaluateMyCART(XY, kFolds, maxDepth, minSize,problemType);
PerformanceReportRegression(testX,actual,predicted);

PlotRegressionResults(testX,actual,predicted,2,'Regression CART')