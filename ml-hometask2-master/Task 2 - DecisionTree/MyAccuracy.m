function accuracy = MyAccuracy(actual, predicted)
    correct = length(find(actual == predicted));
    accuracy = correct / length(actual);
end