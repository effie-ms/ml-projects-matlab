function score = MySSE(groups)
    if size(groups.left, 1) == 0
        ssrLeft = 0;
    else 
        dX = size(groups.left,2);
        meanLeft = mean(groups.left(:,dX));
        ssrLeft = sum((groups.left(:,dX) - meanLeft) .^ 2);
    end
    if size(groups.right, 1) == 0
        ssrRight = 0;
    else
        dX = size(groups.right,2);
        meanRight = mean(groups.right(:,dX));
        ssrRight = sum((groups.right(:,dX) - meanRight) .^ 2);
    end
    score = (ssrLeft + ssrRight);
end

