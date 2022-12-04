function [X, y] = GetRegressionDataset1()
%GETREGRESSIONDATASET1 2D dataset for regression
    rng(5);
    X = rand(500,1);
    y = 2 * X + 3;
    plot(X(:,1),y,'r.')
    
    title("y = 2x + 3")
    xlabel("x")
    ylabel("y")
    
    grid on
    XR1 = [X y];
    save('XR1.mat','XR1');
end
