function distFunction = ChooseBestDistFunctionForK(X,k,distFuncList,maxIter,eps)
    silhVector = zeros(length(distFuncList),1);
    for d = 1:length(distFuncList)
        distanceFunction = distFuncList(d);
        [clusters,~] = MyRepresentativeBasedClustering(X,k,"kmeans",distanceFunction,maxIter,eps);
        silhVector(d) = GetClusterAverageSilhouetteCoefficient(clusters,k,silhouette(X,clusters));
    end
    [maxSilh,idx] = max(silhVector);
    distFunction = distFuncList(idx);
end

