clear 
clc
close all

origin = [0,0];
x = (-50:50)' .* 0.1;
y = x;

%% Generate dataset
rng(1);
covX = GenerateCovarienceMatrix(2);
meanX = origin;
n = 300;
X = mvnrnd(meanX,covX,n);

figure(1);

% Plot points
scatter3(X(:,1),X(:,2),zeros(length(X(:,1)),1))
hold on

z = zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
        z(i,j) = MyDistanceFunction([x(i),y(j)],origin,'mahalanobis',X);
    end
end

color = ones(length(x),length(y),1) .* 2;
surf(x,y,z,color)
xlabel("1st dimension")
ylabel("2nd dimension")
zlabel("3rd dimension")
title("3D representation of Mahalanobis distance function")
hold on

%% Rotate dataset by angle degrees
angle = 60;
R = [ [cos(angle), -sin(angle)];[sin(angle), cos(angle)]];
rotX = (R*(X'))';
scatter3(rotX(:,1),rotX(:,2),zeros(length(rotX(:,1)),1))
hold on

rotPoints = (R*([x,y]'))';
rotPX = rotPoints(:,1);
rotPY = rotPoints(:,2);

rotZ = zeros(length(rotPX),length(rotPY));
for i=1:length(rotPX)
    for j=1:length(rotPY)
        rotZ(i,j) = MyDistanceFunction([rotPX(i),rotPY(j)],origin,'mahalanobis',rotX);
    end
end

color = ones(length(rotPX),length(rotPY),1) .* 3;
surf(rotPX,rotPY,rotZ,color)
xlabel("1st dimension")
ylabel("2nd dimension")
zlabel("3rd dimension")
title("3D representation of Mahalanobis distance function - rotation")

hold off