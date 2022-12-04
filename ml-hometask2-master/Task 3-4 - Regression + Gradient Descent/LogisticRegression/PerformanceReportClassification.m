function stats = PerformanceReportClassification(actual,predicted)
    confusionMatrix = confusionmat(actual,predicted);
    k = size(confusionMatrix,1);
    totalSamples = sum(sum(confusionMatrix));
    [TP,TN,FP,FN,accuracy,sensitivity,specificity,precision,fscore,recall] = deal(zeros(k,1));
    for class = 1:k
        TP(class) = confusionMatrix(class,class);
        temp = confusionMatrix;
        temp(:,class) = []; 
        temp(class,:) = []; 
        TN(class) = sum(sum(temp));
        FP(class) = sum(confusionMatrix(:,class))-TP(class);
        FN(class) = sum(confusionMatrix(class,:))-TP(class);
    end
    for class = 1:k
        accuracy(class) = (TP(class) + TN(class)) / totalSamples;
        sensitivity(class) = TP(class) / (TP(class) + FN(class));
        specificity(class) = TN(class) / (FP(class) + TN(class));
        precision(class) = TP(class) / (TP(class) + FP(class));
        fscore(class) = 2*TP(class)/(2*TP(class) + FP(class) + FN(class));
        recall(class) = TP(class) / (TP(class) + FN(class));
    end
    stats = struct('ConfusionMatrix',confusionMatrix,'AverageAccuracy',mean(accuracy),'AverageSensitivity',mean(sensitivity),'AverageSpecificity',mean(specificity),'AveragePrecision',mean(precision),'AverageRecall',mean(recall),'AverageFScore',mean(fscore));
end

