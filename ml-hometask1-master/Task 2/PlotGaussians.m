function PlotGaussians(DD,figN,labels,titleString)
k = length(unique(labels));
fh(figN) = figure(figN);
clf(fh(figN))
for i=1:size(DD,1)
    scatter(DD(i,1),DD(i,2),k,labels(i))
    hold on
end
for i = 1:k
    clusterIndices = (labels == i);
    cluster = DD(clusterIndices,:);
    DrawEllipses(mean(cluster,1),cov(cluster));
    hold on
end
title(titleString)
end
