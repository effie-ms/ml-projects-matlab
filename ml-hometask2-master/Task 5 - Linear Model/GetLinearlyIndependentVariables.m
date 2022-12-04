function linearlyIndependentVariablesIndices = GetLinearlyIndependentVariables(X, correlationThreshold)
    [nX, dX] = size(X);
    R = corrcoef(X);
    linearlyIndependentVariablesIndices = [1];
    for i = 2:dX
        if AreLinearlyDependent(linearlyIndependentVariablesIndices, i, R, correlationThreshold) == false
            linearlyIndependentVariablesIndices = [linearlyIndependentVariablesIndices; i];
        end   
    end
end

function flag = AreLinearlyDependent(linIndVarsIdxs, idx, R, correlationThreshold)
    for i = 1:length(linIndVarsIdxs)
        j = linIndVarsIdxs(i);
        if abs(R(j,idx)) >= correlationThreshold
            flag = true;
            return;
        end
    end
    flag = false;
end