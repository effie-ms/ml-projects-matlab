function [X, y] = GetRegressionDataset2()
%GETREGRESSIONDATASET2 3D dataset for regression
    rng(5);
    x1 = rand(500,1);
    x2 = rand(500,1);
    X = [x1 x2];
    y = x1 + 3 .* x2;
    plot3(X(:,1),X(:,2),y,'r.')
    
    title("y = x1 + 3x2")
    xlabel("x1")
    ylabel("x2")
    zlabel("y")
    
    grid on
    XR2 = [X y];
    save('XR2.mat','XR2');
end




