function [D,D1] = MyDistanceFunction(Y,X,distFunction,S)
%Pairwise distance between two sets of observations.
% Y - current point
% X - another point/sample for Mahalanobis
% distFunction - the name of a distance function
% D - distance matrix

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
        error(message('Error: dimensionalities should coincide'));
    end
    
    D = zeros(nX,nY);
    D1 = zeros(nX,nY);
    
    if strcmp(distFunction,'mahalanobis') && abs(det(cov(X))) < 1e-12 
        distFunction = 'euclidean';
    end
    
    for i = 1:nY
        for j = 1:nX
            switch distFunction
                case 'cityblock'           
                    d = MyManhattanDistance(Y(i,:),X(j,:));
                    d1 = pdist2(Y(i,:),X(j,:),'cityblock');
                case 'euclidean'
                    d = MyEuclideanDistance(Y(i,:),X(j,:));
                    d1 = pdist2(Y(i,:),X(j,:),'euclidean');
                case 'chebychev'
                    d = MyChebyshevDistance(Y(i,:),X(j,:)); 
                    d1 = pdist2(Y(i,:),X(j,:),'chebychev');
                case 'canberra'
                    d = MyCanberraDistance(Y(i,:),X(j,:));
                    d1 = MyCanberraDistance(Y(i,:),X(j,:));
                case 'cosine'
                    d = MyCosineDistance(Y(i,:),X(j,:));
                    d1 = pdist2(Y(i,:),X(j,:),'cosine');                  
                case 'mahalanobis'
                    d = MyMahalanobisDistance(Y(i,:),X(j,:),S);
                    d1 = pdist2(Y(i,:),X(j,:),'mahalanobis',cov(S));
                    
                otherwise
                    d = MyEuclideanDistance(Y(i,:),X(j,:));
                    d1 = pdist2(Y(i,:),X(j,:),'euclidean');
            end
            D(j,i) = d;
            D1(j,i) = d1;
        end
    end           
end

