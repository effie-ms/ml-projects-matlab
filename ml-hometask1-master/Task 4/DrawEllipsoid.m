function DrawEllipsoid(meanVector, covMatrix,color)
    [X,Y,Z] = sphere;
    sphereCoord = [X(:), Y(:), Z(:)]';
    [eigenVectors,eigenValuesDiag]=eig(covMatrix);
    ellipsoidCoord = eigenVectors*sqrt(eigenValuesDiag)*sphereCoord + meanVector; 
    mesh(reshape(ellipsoidCoord(1,:), size(X)),reshape(ellipsoidCoord(2,:), size(Y)),reshape(ellipsoidCoord(3,:), size(Z)), ones(size(Z)).* color);
    hold on
 end

