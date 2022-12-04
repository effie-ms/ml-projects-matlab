% Average by clusters silhouette coefficient
function avgSilhCoeff = GetClusterAverageSilhouetteCoefficient(idx,k,allSilhoeuetteCoefficients)
    avgClusterSilhoetteCoefficients = zeros(k,1);
    for i=1:k
        clusterPointsIndices = find(idx == i);
        clusterSize = size(clusterPointsIndices,1);
        clusterSilhoetteCoefficients = allSilhoeuetteCoefficients(clusterPointsIndices,1);
        avgClusterSilhoetteCoefficients(i) = sum(clusterSilhoetteCoefficients)/clusterSize;
    end
    avgSilhCoeff = sum(avgClusterSilhoetteCoefficients)/k;
end
