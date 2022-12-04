function predictions = PredictKNN(trainSet,testSet,k,distFunction,problem)
    [nTest, ~] = size(testSet);
    predictions = zeros(nTest,1);
    for i = 1:nTest
        testInstance = testSet(i,:);
        neighbours = GetNeighbours(trainSet,testInstance,k,distFunction);
        if strcmp(problem,'regression')
            predictions(i) = GetResponseRegression(neighbours,'mean');
        else
            predictions(i) = GetResponseClassification(neighbours);
        end
    end
end

function neighbours = GetNeighbours(trainSet,testInstance,k,distFunction)
    [nTrain,dTrain] = size(trainSet);
    distances = zeros(nTrain,1);
    for i = 1:nTrain
		distances(i) = MyDistanceFunction(testInstance, trainSet(i,1:(dTrain-1)),distFunction,trainSet(:,1:(dTrain-1)));
    end
    [~,sortedIndices] = sortrows(distances);
	neighbours = zeros(k,dTrain);
    for i = 1:k
        neighbourIndex = sortedIndices(i);
		neighbours(i,:) = trainSet(neighbourIndex,:);
    end 
end

function response = GetResponseClassification(neighbours)
    [k, dim] = size(neighbours);
    responses = neighbours(:,dim);
    majorityResponses = mode(responses);
    response = majorityResponses(1);
    if length(majorityResponses) > 1 && mod(k,2) ~= 0
        response = majorityResponses(2);
    end
end

function response = GetResponseRegression(neighbours,centroid)
    [~, dim] = size(neighbours);
    neighbours = neighbours(:,dim);
    switch centroid
        case 'mean'
            response = mean(neighbours);
        case 'median'
            response = median(neighnours);
    end
end

