function PlotGaussians(X,figN,labels,titleString)
    k = length(unique(labels));
    fh(figN) = figure(figN);
    clf(fh(figN))
    for i=1:size(X,1)
        scatter(X(i,1),X(i,2),k,labels(i))
        hold on
    end
    for i = 1:k
        clusterIndices = (labels == i);
        cluster = X(clusterIndices,:);
        DrawEllipses(mean(cluster,1),cov(cluster));
        hold on
    end
    title(titleString)
end

function DrawEllipses(means,covMatrix)
% perform eigen decomposition
    [eigenVectors,eigenValues]=eig(covMatrix);
	eigenValues=eigenValues.*9;
    ellipse = ellipse2D(sqrt(eigenValues(1,1)),sqrt(eigenValues(2,2)),means(1,1),means(1,2),eigenVectors,20);
    plot(ellipse(:,1),ellipse(:,2))
    hold on
    plot(means(1,1),means(1,2),'o','MarkerFaceColor','magenta','MarkerEdgeColor','green','MarkerSize',10)
end 

function ellipse = ellipse2D(r_1,r_2,c_1,c_2,RotMat,stepsNr)
    % this function returns 2D array of integers representing coordinates of
    % the points of ellipse in 2D space
    theta = 0:(2*pi)/stepsNr:2*pi;
    theta_length = length(theta);
    ellipse = zeros(theta_length,2);
    for i = 1:theta_length
        ellipse(i,1) = r_1*cos(theta(i));
        ellipse(i,2) = r_2*sin(theta(i));
    end
    ellipse=ellipse*RotMat;
    ellipse(:,1)=ellipse(:,1)+c_1;
    ellipse(:,2)=ellipse(:,2)+c_2;
end