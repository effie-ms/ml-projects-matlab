clc
clear
close all

[X,trueLabels] = GetTestDataset();

rng('default');
maxIter = 100;
eps = 1e-3;

kmethods = ["kmeans","kmedians","kmedoids"];
distFunctions = ["cityblock","euclidean","chebychev","cosine","mahalanobis"];

% Test methods for different k and distance functions
kInterval = 3:5;
% for k = kInterval
%     disp(['k=' num2str(k)])
%     silhTable = TestMethodsWithKandDistFunctions(X,kmethods,k,distFunctions,maxIter,eps);
%     disp(silhTable)
% end

distFunctions = ["cityblock","euclidean","chebychev","canberra","cosine","mahalanobis"];

% Best k for distance functions
% ks = zeros(1,length(distFunctions));
% for d = 1:length(distFunctions)
%     distFunction = distFunctions(d);
%     ks(1,d) = ChooseBestKForDistFunction(X,distFunction,kInterval,maxIter,eps);
% end
% bestK = mode(ks);
% ks = [distFunctions; ks];
% ks = [ ["DistFunc";"k"], ks];
% disp(ks)

% Best distance function for k
% bestDistFunctions = [];
% for k = kInterval
%     kbestDistFunc = ChooseBestDistFunctionForK(X,k,distFunctions,maxIter,eps);
%     bestDistFunctions = [bestDistFunctions, kbestDistFunc];
% end
% 
% [s,~,idx]=unique(bestDistFunctions);
% bestDistFunc = s{mode(idx)};
% 
% bestDistFunctions = [kInterval; bestDistFunctions];
% bestDistFunctions = [ ["k";"DistFunc"], bestDistFunctions];
% disp(bestDistFunctions)

% Visualization
k = 4; %bestK;
distanceFunction = "euclidean";%bestDistFunc;

[clusters,centroids] = MyRepresentativeBasedClustering(X,k,"kmeans",distanceFunction,maxIter,eps);
title1 = "True clusters";
PlotGaussians(X,1,trueLabels,title1);
title2 = "kMeans clusters";
PlotGaussians(X,2,clusters,title2);