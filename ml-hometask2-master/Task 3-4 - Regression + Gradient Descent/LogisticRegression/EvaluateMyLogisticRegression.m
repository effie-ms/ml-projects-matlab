function [predicted,actual,testSet,b] = EvaluateMyLogisticRegression(X,nFolds,learningRate,n,coeffMethod)
%EVALUATEALGORITHM Evaluate an algorithm using a cross validation split
    folds = CrossValidationSplit(X, nFolds);
    [nFolds,foldSize,dX] = size(folds);
	scores = zeros(nFolds,1);
    for i = 1:nFolds
        % Take nFolds-1 folds as training data
        [trainSet, testSet] = GetSplittedSubsets(folds,i);      
        [predicted,b] = PredictMyLogisticRegression(trainSet,testSet,coeffMethod,learningRate,n);
        actual = folds(i,:,dX)';
		scores(i) = MyAccuracy(actual, predicted);
    end
    [bestAccuracy, idx] = max(scores);
    [trainSet, testSet] = GetSplittedSubsets(folds,idx);
	[predicted,b] = PredictMyLogisticRegression(trainSet,testSet,coeffMethod,learningRate,n);
    actual = folds(idx,:,dX)';
end

% Split a dataset into k folds
function split = CrossValidationSplit(X, k)
	[nX,dX] = size(X);
    foldSize = round((nX / k), 0);
    split = zeros(k,foldSize,dX); 
    rng(6)
    foldsIndices = ceil(1 + (nX-1) .* rand(foldSize,k));
    for i = 1:k    
		split(i,:,:) = X(foldsIndices(:,i),:);
    end
end

function [trainSet, testSet] = GetSplittedSubsets(folds,i)
    [nFolds,foldSize,dX] = size(folds);
    trainSet = folds;
	trainSet(i,:,:) = [];
    train = zeros((nFolds-1)*foldSize,dX);
    for j = 1:(nFolds-1)
        temp = trainSet(j,:,:);
        for k = 1:foldSize
            train((j-1) * foldSize + k, :) = temp(1,k,:); 
        end
    end 
    trainSet = train;
    % Take left out fold as testing data
	testSet = folds(i,:,:);
    testSet = testSet(1,:,1:(dX-1));
    test = zeros(foldSize,dX-1);
    for k = 1:foldSize
        test(k, :) = testSet(1,k,:); 
    end
    testSet = test;
end