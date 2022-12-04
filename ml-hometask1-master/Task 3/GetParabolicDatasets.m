function [X,labels] = GetParabolicDatasets() 
    stepS = 0.1;
    t=-2:stepS:2;
    tLength = length(t);
    thicknes = 10;

    DS1=[];
    for i=1:tLength
        tSlice = rand(thicknes,2)*1.2;
        x(1:thicknes,1)=tSlice(:,1)+t(i);
        y(1:thicknes,1)=-tSlice(:,2)+t(i)^2;
        DS1 = [DS1;x,y];
    end

    DS2=[];
    for i=1:tLength
        tSlice = rand(thicknes,2)*0.9;
        x(1:thicknes,1)=tSlice(:,1)+t(i)+2;
        y(1:thicknes,1)=tSlice(:,2)-t(i)^2+5.5;
        DS2 = [DS2;x,y];
    end

    labels = cat(1,ones(size(DS1,1),1),ones(size(DS2,1),1).*2);
    
    % join the sets 
    X = [DS1;DS2];
end


