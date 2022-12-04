function hstat = MyHopkinsStatistic(D,R)
%MYHOPKINSSTATISTIC
%   D: dataset to investigate, n x d array
    n = size(D,1);
%   R: representative sample of D, r x d array
	r = size(R,1);
    sIndices = ceil(rand(r,1) * n);
%   S: synthetic dataset, sample from D, r x d array
	S = D(sIndices,:);
    
	distMatrixRD = pdist2(R,D);
	distMatrixSD = pdist2(S,D);
    
    alpha = zeros(r,1);
    beta = zeros(r,1);
    
    for i = 1:r
        sortedDistances1 = sort(distMatrixRD(i,:));
        alpha(i) = sortedDistances1(2); % the 1st is 0 to the point itself
        sortedDistances2 = sort(distMatrixSD(i,:));
        beta(i) = sortedDistances2(2);
    end
    
    if (sum(alpha) == 0 && sum(beta) == 0)
        beta(1) = eps;
    end
	hstat = sum(beta) / (sum(beta) + sum(alpha));
end