function bestSubset = GetBestVariablesSubset(X,Y,correlationThreshold,significanceLevel,qualityThreshold)
    % Investigate collinearity
    linIndependentVars = GetLinearlyIndependentVariables(X, correlationThreshold);
    
    disp("Linearly independent variables: ")
    disp(strjoin(GetVariableNames(linIndependentVars),','))
    
    disp("Exhaustive search:")
    
    k = 1;
    for i = 1:length(linIndependentVars)
        combinations = combnk(linIndependentVars,i);
        for j = 1:size(combinations,1)
            subsets(k).VariableIndices = combinations(j,:);
            subsets(k).VariableNames = GetVariableNames(subsets(k).VariableIndices);
            subsets(k).X = X(:,subsets(k).VariableIndices);
            subsets(k).Y = Y;
            k = k + 1;
        end
    end
    
    for i = 1:(k-1)
        x = subsets(i).X;
        y = subsets(i).Y;
        % Apply least squares method to find model coefficients
        [yhat,b,b0] = PredictLinearRegression(x, y);
        subsets(i).Prediction = yhat;
        subsets(i).Coefficients = b;
        subsets(i).Intercept = b0;
        % Quality
        subsets(i).Stats = PerformanceReportRegression(x,y,yhat);
        output(i) = struct('Variables',strjoin(subsets(i).VariableNames, ','),'AdjustedRSquared',subsets(i).Stats.AdjustedRSquared,'RMSE',subsets(i).Stats.RMSE);
    end
    
    disp(struct2table(output))
    
    bestSubsetIndex = 1;
    for i = 1:numel(subsets)
        if subsets(i).Stats.AdjustedRSquared > subsets(bestSubsetIndex).Stats.AdjustedRSquared 
            bestSubsetIndex = i;
        end
    end
    
    disp("Variable set with the highest quality:")
    
    bestSubset = subsets(bestSubsetIndex);
    disp(bestSubset.VariableNames);
end

function varNames = GetVariableNames(varIndices)
    for i = 1:length(varIndices)
        varNames(i) = strcat("X",string(varIndices(i)));
    end
end