function DrawEllipses(means,covMatrix)
% perform eigen decomposition
    [eigenVectors,eigenValues]=eig(covMatrix);
	eigenValues=eigenValues.*9;
    ellipse = ellipse2D(sqrt(eigenValues(1,1)),sqrt(eigenValues(2,2)),means(1,1),means(1,2),eigenVectors,20);
    plot(ellipse(:,1),ellipse(:,2))
    hold on
    plot(means(1,1),means(1,2),'o','MarkerFaceColor','magenta','MarkerEdgeColor','green','MarkerSize',10)
end 
