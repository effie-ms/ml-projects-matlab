function [X,labels] = GetFlowerTestDataset()
% flower like clusters: overlapping gaussians
% means    
    mu = [0,0];
% sample sizes
    n = 300;
% radiuses
    scaleX = 2;
    scaleY = 10;
    eVal = [scaleX, 0; 0, scaleY];
% covariance matrices
    for i = 1:4
        angle = pi/4;
        eVect = [cos(angle*i), -sin(angle*i); sin(angle*i), cos(angle*i)]; %rotation matrix
        cov(i).matrix = eVect*eVal/eVect;
    end
% generate gaussians
    rng(10);
    for i=1:4
        D(i).set = mvnrnd(mu,cov(i).matrix,n);
    end
% create a flower from gaussians
    X = cat(1,D(1).set, D(2).set, D(3).set, D(4).set); 
    labels = cat(1,ones(n,1),ones(n,1).*2,ones(n,1).*3,ones(n,1).*4);
    PlotGaussians(X,1,labels,'Flower Gaussian Mixture')
    XC3 = [X labels];
    save('XC3.mat','XC3');
end



