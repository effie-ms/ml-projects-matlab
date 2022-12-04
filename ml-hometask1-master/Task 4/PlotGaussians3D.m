function [] = PlotGaussians3D(X,figN,labels,titleString,drawEllipsoids)
    k = length(unique(labels));
    fh(figN) = figure(figN);
    clf(fh(figN))
    for i=1:size(X,1)
        scatter3(X(i,1),X(i,2),X(i,3),10,labels(i),'filled')
        hold on
    end
    if drawEllipsoids == 1
        D1 = X(labels == 1,:);
        D2 = X(labels == 2,:);
        D3 = X(labels == 3,:);
        DrawEllipsoid(mean(D1,1)', cov(D1),1)
        DrawEllipsoid(mean(D2,1)', cov(D2),2)
        DrawEllipsoid(mean(D3,1)', cov(D3),3)
    end
    title(titleString)
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
end

