% Find "optimal" hyperparameters for DBSCAN
% P.S. plain heuristic 
function [eps,tau] = GetOptimalParameters(X)
    D = pdist2(X,X);
    [nD,dD] = size(D);
    % Estimate eps
    vD = GetMinDistanceVector(D);
    figure(2);
    hist(vD,length(vD)/2);
    title("Distribution of the closest neighbour distances")
    xlabel("Distance to the closest neighbour")
    ylabel("Number of points")
    [nDistBins,edgesDistBins] = histcounts(vD,length(vD));
    n = 0.997 * nD;
    cumSums = cumsum(nDistBins);
    [~, idx] = min(abs(n-cumSums));
    % Find mean of the bin
    leftEdge = edgesDistBins(idx);
    rightEdge = edgesDistBins(idx+1);
    % around 99.7% of points have their closest neighbours in within a
    % radius eps
    eps = (rightEdge + leftEdge)/2;
    % Estimate tau
    nn = zeros(nD,1);
    for i = 1:nD
        nn(i) = length(find(D(i,:) <= eps));
    end
    figure(3)
    hist(nn,length(nn)/2)
    title(['Distribution of the eps-neighbourhoods sizes, eps=' num2str(eps)])
    xlabel("Eps-neighbourhood size")
    ylabel("Number of points")
    [nEpsNeighbBins,edgesEpsNeighbBins] = histcounts(nn,length(nn));
    n = (1 - 0.997) * nD;
    cumSums = cumsum(nEpsNeighbBins);
    [~, idx] = min(abs(n-cumSums));
    % Find mean of the bin
    leftEdge = edgesEpsNeighbBins(idx);
    rightEdge = edgesEpsNeighbBins(idx+1);
    % Around 99.7% of points have not less then tau points in their eps-neighbourhood
    tau = (leftEdge + rightEdge)/2;
end

% Get the distances of the closest neighbours for each point
function vD = GetMinDistanceVector(D)
    [nD,dD] = size(D);
    vD = zeros(nD,1);
    for i = 1:nD
        sortedDist = sort(D(i,:));
        vD(i) = sortedDist(2); 
    end
end

