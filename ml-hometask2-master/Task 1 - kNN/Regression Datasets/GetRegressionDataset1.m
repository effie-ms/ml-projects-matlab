function [X, y] = GetRegressionDataset1()
%GETREGRESSIONDATASET1 2D dataset for regression
    rng(5);
    X = rand(500,1);
    y = 2 * X .^ 2 + 3 * exp(-X);
    plot(X(:,1),y,'r.')
    
    title("2x^2 + 3exp(-x)")
    xlabel("x")
    ylabel("y")
    
    grid on
    XR1 = [X y];
    save('XR1.mat','XR1');
end
