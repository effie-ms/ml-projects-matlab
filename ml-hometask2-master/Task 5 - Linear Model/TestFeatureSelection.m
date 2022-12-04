clear
clc

data = load('D');
XY = data.D;

X = XY(:,1:(size(XY,2)-1));
Y = XY(:,size(XY,2));

correlationThreshold = 0.75;
qualityThreshold = 0.9; 
significanceLevel = 0.05;

result = GetBestVariablesSubset(X,Y,correlationThreshold,significanceLevel,qualityThreshold);


