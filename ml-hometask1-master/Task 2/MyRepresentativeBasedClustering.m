function [clusterLabels, centroids, iter] = MyRepresentativeBasedClustering(X,k,method,distanceFunction,maxIterations,eps)
%MyRepresentativeBasedClustering Representative-based clustering
    %Input: 
        %X - data points
        %k - number of clusters
        %method: 'kmeans','kmedians','kmedoids'
        %distanceFunction: see myDistanceFunction
        %maxIterations: maximum number of iterations
        %eps: convergence shift of centroids
    %Output: 
        %clusterLabels - cluster labels of each point
        %centroids - cluster centroids
        %iter - the number of iterations
    [nX,dX] = size(X); 
    centroids = X(ceil(rand(k,1)*nX),:);
    prevClusterLabels = zeros(nX,1); % temporary vector for clusters
    
    for n = 1:maxIterations 
         prevCentroids = centroids;
         dist = zeros(nX,size(centroids,1));
         for c = 1:size(centroids,1)
             dist(:,c) = MyDistanceFunction(centroids(c,:),X,distanceFunction,X); % distance between all data points and centroids
         end
         % Expectation: associates the closest point to each center to its cluster.
         [~, clusterLabels] = min(dist,[],2); % find minimum distance of all points to the nearest centroid
         
         % Maximization: Update the center of the clusters according to the updated labels in the previous step
         for i = 1:k
             clusterPointsIndices = find(clusterLabels == i);
             switch method
                 case 'kmeans'
                     centroids(i,:) = mean(X(clusterPointsIndices,:),1);
                 case 'kmedians'
                     centroids(i,:) = median(X(clusterPointsIndices,:),1);
             end
             
             %Convergence criterion 1
             % When centroids don't change between iterations
             if clusterLabels == prevClusterLabels 
                break; 
             else
                prevClusterLabels = clusterLabels;
             end
             
             %Convergence criterion 2
             % Calculate the shift
             shift = norm(prevCentroids-centroids,2);
             if shift < eps
                break;
             end   
         end          
    end
    iter = n;
end