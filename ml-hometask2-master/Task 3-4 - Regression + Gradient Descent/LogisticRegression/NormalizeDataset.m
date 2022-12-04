function X = NormalizeDataset(X)
%NORMALIZEDATASET Rescale dataset columns to the range 0-1
    [nX,dX] = size(X);
    for k = 1:nX
        for i = 1:dX
			X(k,i) = (X(k,i) - min(X(k,:))) / (max(X(k,:)) - min(X(k,:)));
        end
    end
end