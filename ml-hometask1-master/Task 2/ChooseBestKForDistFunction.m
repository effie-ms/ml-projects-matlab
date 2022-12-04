function k = ChooseBestKForDistFunction(X,distFunction,kInterval,maxIter,eps)
    silhVector = zeros(length(kInterval),1);
    i = 1;
    for k = kInterval
        [clusters,~] = MyRepresentativeBasedClustering(X,k,"kmeans",distFunction,maxIter,eps);
        silhVector(i) = GetClusterAverageSilhouetteCoefficient(clusters,k,silhouette(X,clusters));
        i = i+1;
    end
    [maxSilh,idx] = max(silhVector);
    k = kInterval(idx);
end

