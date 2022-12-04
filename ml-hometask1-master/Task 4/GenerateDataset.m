clc
clear
close all

% Initial random parameters
m = [2;2;2];
eigVect = [1,0,0; 0,1,0; 0,0,1];
eigVal = [1,1,1];
covM = eigVect.*eigVal/eigVect;
n = 100;
% Random generation
rng(1);
D1 = mvnrnd(2.*m,covM,n);
rng(2);
D2 = mvnrnd(3.*m,covM,n);
rng(3);
D3 = mvnrnd(4.*m,covM,n);

%Adjusting
D2(:,1) = D1(:,1);
D1(:,2) = D2(:,2);
D3(:,2) = D2(:,2);
D2(:,3) = D3(:,3);

%Dataset
X = [D1; D2; D3];
labels = [ones(n,1); ones(n,1).*2 ; ones(n,1).*3];

%Feature selection: Hopkins statistics
% hopkStatTable = GetHopkinsStatisticsByFeatures(X,D1,D2,D3);
% disp(hopkStatTable)

%Feature selection: Entropy
%entropiesTable = GetEntropyValuesByFeatures(X,3);
%disp(entropiesTable)

%Visualization
kmeansLabels = kmeans(X,3);
PlotGaussians3D(X,1,labels,"True labels",1);
PlotGaussians3D(X,2,kmeansLabels,"kMeans labels",1);
PlotGaussians3D(X,3,labels,"True labels",0);
PlotGaussians3D(X,4,kmeansLabels,"kMeans labels",0);


