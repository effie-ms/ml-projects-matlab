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

%% Prepare data
XY(:,1:(size(XY,2)-1)) = NormalizeDataset(XY(:,1:(size(XY,2)-1)));

%% Modeling
% Cross-validation parameters
kFolds = 10;
% Decision tree parameters
maxDepth = 5; % maximum depth of the tree
minSize = 10; % minimum number of instances in the node

%% Get predictions
[predicted,actual,testX] = EvaluateMyCART(XY, kFolds, maxDepth, minSize,problemType);
stats = PerformanceReportClassification(actual,predicted);
disp(stats)
disp(stats.ConfusionMatrix)

PlotClasses(testX,actual,predicted,2,'Classification CART');