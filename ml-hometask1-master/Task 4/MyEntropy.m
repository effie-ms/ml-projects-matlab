function entropy = MyEntropy(clusters)
%MYENTROPY Entropy feature selection measure
%   clusters: n x 1 array of cluster labels
	m = size(unique(clusters),1); % number of clusters
	n = size(clusters,1); % number of points in the dataset
	p = zeros(m,1);
    for i=1:m
		p(i) = size(clusters(clusters == i),1) / n;
    end
    entropy = -sum(p .* log(p) + (1 - p) .* log(1 - p));
end
