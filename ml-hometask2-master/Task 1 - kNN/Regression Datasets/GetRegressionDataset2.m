function [X, y] = GetRegressionDataset2()
%GETREGRESSIONDATASET2 3D dataset for regression
    rng(5);
    x1 = rand(500,1);
    x2 = rand(500,1);
    X = [x1 x2];
    y = (x1 .^ 2) + 3 .* (x2 .^ 2) + 2.*x1.*x2;
    
    plot3(X(:,1),X(:,2),y,'r.')
    
    % plot surface
%     x11 = (1:50)';
%     x12 = (1:50)';
%     z = zeros(length(x11),length(x12));
%     for i = 1:length(x11)
%         for j = 1:length(x12)
%             z(i,j) = (x11(i) .^ 2) + 3 .* (x12(j) .^ 2) + 2.*x11(i).*x12(j);
%         end
%     end
%     surf(x11,x12,z)

    title("y = x1^2 + 3*x2^2 + 2*x1*x2")
    xlabel("x1")
    ylabel("x2")
    zlabel("y")
    
      
    grid on
    XR2 = [X y];
    save('XR2.mat','XR2');
end




