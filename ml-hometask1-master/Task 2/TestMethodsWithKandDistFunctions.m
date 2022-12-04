function silhTable = TestMethodsWithKandDistFunctions(X,kmethods,k,distFunctions,maxIter,eps)
    silhTable = zeros(length(kmethods),length(distFunctions));
    for m = 1:length(kmethods)
        method = kmethods(m);
        for d = 1:length(distFunctions)
            distanceFunction = distFunctions(d);
            if strcmp(method,'kmedoids')
                [clusters,~] = kmedoids(X,k,'Distance',distanceFunction);
            else
                [clusters,~] = MyRepresentativeBasedClustering(X,k,method,distanceFunction,maxIter,eps);
            end
            silhTable(m,d) = GetClusterAverageSilhouetteCoefficient(clusters,k,silhouette(X,clusters));
        end
    end    
    silhTable = [distFunctions; silhTable];
    silhTable = [ ["DistFunc"; kmethods'], silhTable];
end

