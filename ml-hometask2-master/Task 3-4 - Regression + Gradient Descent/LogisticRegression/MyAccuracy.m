function accuracy = MyAccuracy(actual, predicted)
%MYACCURACY Calculate accuracy
    correct = length(find(actual == predicted));
    accuracy = correct / length(actual);
end