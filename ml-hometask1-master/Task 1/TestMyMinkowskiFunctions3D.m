clear 
clc
close all

distFunctionsNames = ["cityblock","euclidean","chebychev"];

origin = [0,0];
x = (-50:50)' .* 0.1;
y = x;

figure(1)

for k=1:length(distFunctionsNames)
    z = zeros(length(x),length(y));
    distFuncName = distFunctionsNames(k);
    for i=1:length(x)
        for j=1:length(y)
            z(i,j) = MyDistanceFunction(origin,[x(i),y(j)],distFuncName);
        end
    end
    color = ones(length(x),length(y),1) .* k;
    surf(x,y,z,color)
    xlabel("1st dimension")
    ylabel("2nd dimension")
    zlabel("3rd dimension")
    title("3D representation of Minkowski distances")
    hold on
end
legend('Manhattan','Euclidean','Chebyshev')

hold off


