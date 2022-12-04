function D = MyDistanceFunction(Y,X,distFunction,S)
%Pairwise distance between two sets of observations.
% Input:
%   Y - point1
%   X - point2
%   S - sample for Mahalanobis
%   distFunction - the name of a distance function
% Output:
%   D - distance matrix (my implementation)

MyMinkowskiDistance = @(point1,point2,order) (sum(abs(point1 - point2).^order)^(1 / order));
MyManhattanDistance = @(point1,point2) MyMinkowskiDistance(point1,point2,1);
MyEuclideanDistance = @(point1,point2) MyMinkowskiDistance(point1,point2,2);
MyChebyshevDistance = @(point1,point2) (max(abs(point1-point2)));
MyCanberraDistance = @(point1,point2) (sum(abs(point1-point2) / (abs(point1) + abs(point2))));
MyCosineDistance = @(point1,point2) 1-(sum(point1.*point2) ./ (sqrt(sum(point1.^2)) .* sqrt(sum(point2.^2))));
MyMahalanobisDistance = @(point1,point2,sample) (sqrt((point1 - point2) / cov(sample) * (point1 - point2)'));

    [nX,dX] = size(X);
    [nY,dY] = size(Y);
    if dY ~= dX
        error(message('different dimensionalities of points'));
    end
    
    D = zeros(nX,nY);
    
    if strcmp(distFunction,'mahalanobis') && abs(det(cov(X))) < 1e-12 
        distFunction = 'euclidean';
    end
    
    for i = 1:nY
        for j = 1:nX
            switch distFunction
                case 'cityblock'           
                    d = MyManhattanDistance(Y(i,:),X(j,:));
                case 'euclidean'
                    d = MyEuclideanDistance(Y(i,:),X(j,:));
                case 'chebychev'
                    d = MyChebyshevDistance(Y(i,:),X(j,:)); 
                case 'canberra'
                    d = MyCanberraDistance(Y(i,:),X(j,:));
                case 'cosine'
                    d = MyCosineDistance(Y(i,:),X(j,:));                 
                case 'mahalanobis'
                    d = MyMahalanobisDistance(Y(i,:),X(j,:),S);                   
                otherwise
                    d = MyEuclideanDistance(Y(i,:),X(j,:));
            end
            D(j,i) = d;
        end
    end           
end

