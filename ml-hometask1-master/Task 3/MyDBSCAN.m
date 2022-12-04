function idx = MyDBSCAN(X,eps,tau)
%MYDBSCAN DBSCAN clustering algorithm
%Input:
%   X: dataset, nX x dX array
%   tau - density threshold
%   eps - radius of the neighbourhood
%Output:
%   idx - cluster indices
%       !0-labeled points are outliers (noise points)
    
    [nX,dX]=size(X);
    idx=zeros(nX,1);
    visited = zeros(nX,1);
    label=0;

    % Distance matrix
    D = MyDistanceFunction(X,X,'euclidean');

    for i=1:nX
        if ~visited(i)
            visited(i) = 1;    
            iEpsNeighbourhood = GetEpsNeighbourhood(i,D,eps);
            if IsCorePoint(iEpsNeighbourhood,tau)
                label = label+1;
                [idx,visited] = ConnectPoints(i,iEpsNeighbourhood,idx,label,visited,D,eps,tau);
            end          
        end 
    end
end

function isCorePoint = IsCorePoint(epsNeighbourhood,tau)
    isCorePoint = (length(epsNeighbourhood) >= tau);
end

function epsNeighbourhood = GetEpsNeighbourhood(i,distMatrix,eps)
    epsNeighbourhood = find(distMatrix(i,:) <= eps);
    epsNeighbourhood = epsNeighbourhood';
end
    
function [idx,visited] = ConnectPoints(i,iEpsNeighbourhood,idx,label,visited,D,eps,tau)
    idx(i)=label;
    k = 1;
    while true
        j = iEpsNeighbourhood(k);         
        if ~visited(j)
            visited(j) = 1;
            jEpsNeighbourhood = GetEpsNeighbourhood(j,D,eps);
            if IsCorePoint(jEpsNeighbourhood,tau)
                % Connect neighbourhoods
                iEpsNeighbourhood = [iEpsNeighbourhood;jEpsNeighbourhood];
            end
        end
        % Add jth point to a cluster
        if idx(j) == 0
            idx(j) = label;
        end
            
        k = k + 1;
        % All the points in the neighbourhood are connected
        if k > length(iEpsNeighbourhood)
            break;
        end
    end
end