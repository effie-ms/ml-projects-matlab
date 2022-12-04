function predictions = PredictMyCART(trainSet, testSet, maxDepth, minSize,problem)
    [nTest,~] = size(testSet);
	treeModel = BuildDecisionTree(trainSet, maxDepth, minSize,problem);
	predictions = zeros(nTest,1);
    for i = 1:nTest
        testInstance = testSet(i,:);
		predictions(i) = Predict(testInstance, treeModel);
    end
end

function root = BuildDecisionTree(trainSet, maxDepth, minSize,problem)
    root = GetSplit(trainSet,problem);
    root = Split(root, maxDepth, minSize, 1, problem);
    PrintTree(root, 0);
end

function prediction = Predict(testInstance,treeModel)
    node = treeModel;
    if testInstance(node.index) < node.value
        if class(node.groups.left) ~= 'double'
			prediction = Predict(testInstance, node.groups.left);
        else
			prediction = node.groups.left;
        end
    else
        if class(node.groups.right) ~= 'double'
			prediction = Predict(testInstance, node.groups.right);
        else
			prediction = node.groups.right;
        end
    end
end

function PrintTree(node, depth)
    if class(node) ~= 'double'
		disp(strcat(string(depth),'[X',string(node.index),'<', string(node.value),']'))
		PrintTree(node.groups.left, depth+1)
		PrintTree(node.groups.right, depth+1)
    else
		disp(strcat(string(depth),':',string(node)))
    end
end

% Split a dataset X based on a feature and a feature value
function groups = TestSplit(featureIndex, featureValue, X)
    [nX, ~] = size(X);
	left = [];
    right = [];
    for i = 1:nX
        instance = X(i,:);
        if instance(featureIndex) < featureValue
			left = [left; instance];
        else
			right = [right; instance];
        end
    end
    groups.left = left;
    groups.right = right;
end

% select a class value for a group of rows
function terminalNodeValue = ToTerminal(group)
    [nGroup,dGroup] = size(group);
    responses = group(:,dGroup);
    [labels,~,indices] = unique(responses);
    votes = accumarray(indices,1);
    labelsWithVotes = [labels, votes];
    [sortedVotes,~] = sortrows(labelsWithVotes,2,'descend');
    terminalNodeValue = sortedVotes(1,1); %the most common output value in the list
end

% Select the best split point for a dataset
function split = GetSplit(X,problem)
    [nX,dX] = size(X);
    labels = X(:,dX);
	bestIndex = Inf;
    bestValue = Inf;
    bestScore = Inf;
    bestGroups = [];
    for index = 1:(dX-1)
        for j = 1:nX
            instance = X(j,:);
			groups = TestSplit(index, instance(index), X);
            if strcmp(problem,'classification')
                score = MyGiniIndex(groups, labels);
            else
                score = MySSE(groups);
            end
            %disp(strcat('X',string(index),'<',string(instance(index)),' Gini=', string(gini)))
            if score < bestScore
				bestIndex = index;
                bestValue = instance(index);
                bestScore = score;
                bestGroups = groups;
            end
        end
    end
    split.index = bestIndex;
    split.value = bestValue;
    split.groups = bestGroups;
    %disp(strcat('Split: [X',string(split.index),'<',string(split.value),']'))
end

% Create child splits for a node or make terminal
function node = Split(node, maxDepth, minSize, depth,problem)
	left = node.groups.left;
    right = node.groups.right;
	node.groups = [];
    if isempty(left) || isempty(right)
        groupInstances = [left; right];
		node.groups.left = ToTerminal(groupInstances);
        node.groups.right = ToTerminal(groupInstances);
		return
    end
    if depth >= maxDepth
		node.groups.left = ToTerminal(left);
        node.groups.right = ToTerminal(right);
		return
    end
    if size(left,1) <= minSize
		node.groups.left = ToTerminal(left);
    else
		node.groups.left = GetSplit(left,problem);
		node.groups.left = Split(node.groups.left, maxDepth, minSize, depth+1,problem);
    end
    if size(right,1) <= minSize
		node.groups.right = ToTerminal(right);
    else
		node.groups.right = GetSplit(right,problem);
		node.groups.right = Split(node.groups.right, maxDepth, minSize, depth+1,problem);
    end
end
