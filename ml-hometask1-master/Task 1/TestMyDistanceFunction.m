clear 
clc
close all

distFunctionsNames = ["cityblock","euclidean","chebychev","canberra","cosine"];

center = [2,2];
angle = 0:pi/72:2*pi;
r = 3;
x = r * cos(angle) + center(1);
y = r * sin(angle) + center(2);

radiuses = zeros(length(distFunctionsNames),length(x));
for i=1:length(distFunctionsNames)
    distFuncName = distFunctionsNames(i);
    for j=1:length(x)
        radiuses(i,j) = MyDistanceFunction(center,[x(j),y(j)],distFuncName);
    end
end

x = radiuses .* cos(angle) + center(1);
y = radiuses .* sin(angle) + center(2);

figure(1)
plot(x(1,:),y(1,:),x(2,:),y(2,:),x(3,:),y(3,:),x(4,:),y(4,:),x(5,:),y(5,:),'LineWidth',2)
legend('Manhattan','Euclidean','Chebyshev','Canberra','Cosine')
grid on