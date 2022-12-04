clc;
clear;
close all;

% X1
data = load('X');
X1 = data.X;
% X2
[X2,~] = GetParabolicDatasets();

%X = X1;
X = X2;

idx = MyDBSCANFull(X);

function idx = MyDBSCANFull(X)
    [eps,tau] = GetOptimalParameters(X);
    idx = MyDBSCAN(X,eps,tau);
    titleString = ['DBSCAN (eps = ' num2str(eps) ', tau = ' num2str(tau) ')'];
    PlotClusters(X,1,idx,titleString);

    k = length(unique(idx))-1;
    allSilhoeuetteCoefficients = silhouette(X,idx);
    avgSilhCoeff = GetClusterAverageSilhouetteCoefficient(idx,k,allSilhoeuetteCoefficients);
    disp(['Average clustering coefficient ' num2str(avgSilhCoeff)])
end