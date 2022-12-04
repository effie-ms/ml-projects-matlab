function PlotGaussians(DD,figN,labels,titleString)
    PlotClusters(X,figN,labels,titleString);
    k = length(unique(labels));
    for i = 1:k
        clusterIndices = (labels == i);
        cluster = DD(clusterIndices,:);
        DrawEllipses(mean(cluster,1),cov(cluster));
        hold on
    end
end


