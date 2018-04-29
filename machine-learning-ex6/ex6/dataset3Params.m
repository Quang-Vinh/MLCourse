function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

combinations = [];
results = [];
tmp = [0.01 0.03 0.1 0.3 1 3 10 30];

for i = 1:size(tmp, 2)
    combinations = [ combinations ; [ones(size(tmp,2), 1)*tmp(i) tmp'] ];
end

for i = 1:size(combinations, 1)
    disp(i);
    C_test = combinations(i, 1);
    sigma_test = combinations(i, 2);
    model = svmTrain(X, y, C_test, @(x1, x2) @gaussianKernel(x1, x2, sigma_test));

    predictions = svmPredict(model, Xval);
    correct = yval == predictions;
    results(i) = sum(correct) / size(correct, 1);
end

[percentage row] = max(results);

C = combinations(row, 1);
sigma = combinations(row, 2);

% =========================================================================

end
