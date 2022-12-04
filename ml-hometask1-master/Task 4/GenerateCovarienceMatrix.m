function C = GenerateCovarienceMatrix(dim)
% Generate a square, symmetric, positive definite matrix
% Input:
%   dim: square matrix size (number of rows or columns)
% Output:
%   C: square, symmetric, positive definite matrix
    C = rand(dim,dim); % generate a random dim x dim matrix
    C = C*C'; % symmetric matrix
    C = C + dim*eye(dim); %to make it symmetric positive definite
end

