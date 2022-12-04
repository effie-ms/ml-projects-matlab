function gini = MyGiniIndex(groups,classLabels)
    nTotalInstances = size(groups.left,1) + size(groups.right,1);
	gini =  GetGroupGiniIndex(groups.left,unique(classLabels),nTotalInstances) +  GetGroupGiniIndex(groups.right,unique(classLabels),nTotalInstances);
end

function gini = GetGroupGiniIndex(group,classLabels,nTotalInstances)
    nLabels = size(classLabels,1);
    nGroupInstances = size(group,1);
    if nGroupInstances == 0
        gini = 0;
        return
    end
	score = 0;
    for j = 1:nLabels
        classLabel = classLabels(j);
        proportion = length(find(group(:,size(group,2)) == classLabel))/nGroupInstances;
        score = score + proportion^2;
    end
    gini = (1.0 - score) * (nGroupInstances / nTotalInstances);
end