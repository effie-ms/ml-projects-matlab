function entropiesTable = GetEntropyValuesByFeatures(X,k)
    headerCols = [ "dim1", "dim2", "dim3", "dims1,2","dims1,3","dims2,3","dims1,2,3"];
    headerRows = [ "Features"; "Entropy" ];
    values = zeros(1,length(headerCols));
    for i = 1:3
        labels = kmeans(X(:,i),k);
        values(1,i) = MyEntropy(labels);
    end
    c = combnk(1:3,2);
    for i = 4:6
        labels = kmeans(X(:,c(i-3,:)),k);
        values(1,i) = MyEntropy(labels);
    end
    labels = kmeans(X(:,[1,2,3]),k);
    values(1,7) = MyEntropy(labels);    
    entropiesTable = [headerCols; values];
    entropiesTable = [headerRows, entropiesTable];
end

