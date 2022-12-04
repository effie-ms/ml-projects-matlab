function [X,labels] = GetGaussianTestDataset() 
% covariance matrices
    cov(1).matrix = [4, 2; 2, 3];
    cov(2).matrix = [2, -2; -2, 6];
    cov(3).matrix = [1, -0.5; -0.5, 1];
    cov(4).matrix = [1, -0.3; -0.3, 1];
% means
    mean(1).mu = [-8,-7];
    mean(2).mu = [1,0];
    mean(3).mu = [-8,6];
    mean(4).mu = [5,7];
% sample sizes
    n(1) = 300;
    n(2) = 400;
    n(3) = 200;
    n(4) = 100;
% generate dataset
    rng('default');
    for i=1:4
        D(i).set = mvnrnd(mean(i).mu,cov(i).matrix,n(i));
    end
% output
    X = cat(1,D(1).set, D(2).set, D(3).set, D(4).set); 
    labels = cat(1,ones(n(1),1),ones(n(2),1).*2,ones(n(3),1).*3,ones(n(4),1).*4);
    PlotGaussians(X,1,labels,'Gaussians')
    XC1 = [X labels];
    save('XC1.mat','XC1');
end


