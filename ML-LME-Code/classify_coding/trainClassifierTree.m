function [testAccuracy,Micro_F,Macro_F,K,precision]=trainClassifierTree(trainpredictors,trainresponses,valpredictors,valresponses,testpredictors,testresponses)
%   decision tree model
%   Input:
%        trainpredictors,trainresponses,valpredictors,valresponses,testpredictors,testresponses
%        these are from train_val_test_setget.m
%   Output:
%        testAccuracy,Micro_F,Macro_F,K,precision are all judgment indexes
%
%       trainedClassifier.predictFcn: a function to make predictions
%        on new data. It takes an input of the same form as this training
%        code (table or matrix) and returns predictions for the response.
%        If you supply a matrix, include only the predictors columns (or
%        rows).
%
%       validationAccuracy: a double containing the accuracy in
%        percent. In the app, the History list displays this
%        overall accuracy score for each model.
%
%  Use the code to train the model with new data.
%  To retrain your classifier, call the function from the command line
%  with your original data or new data as the input argument trainingData.
%
%  For example, to retrain a classifier trained with the original data set
%  T, enter:
%    [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
%  To make predictions with the returned 'trainedClassifier' on new data T,
%  use
%    yfit = trainedClassifier.predictFcn(T)
%
%  To automate training the same classifier with new data, or to learn how
%  to programmatically train classifiers, examine the generated code.

% Auto-generated by MATLAB on 2020-10-16 23:50:42


% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
% Convert input to table
%{
% change predictorNames to select diffrent index
%all indexs
inputTable = array2table(trainingData, 'VariableNames', {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13', 'column_14'});
predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_14;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false];

%don't use combained index
%{
inputTable = array2table(trainingData, 'VariableNames', {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13','column_14'});
predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_14;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false,  false];
%}
% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationTree = fitctree(...
    predictors, ...
    response, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 20, ...
    'Surrogate', 'off', ...
    'ClassNames', [1; 2; 3]);

% Create the result struct with predict function
predictorExtractionFcn = @(x) array2table(x, 'VariableNames', predictorNames);
treePredictFcn = @(x) predict(classificationTree, x);
trainedClassifier.predictFcn = @(x) treePredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.ClassificationTree = classificationTree;
trainedClassifier.About = 'This struct is a trained classifier exported from Classification Learner R2016b.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new predictor column matrix, X, use: \n  yfit = c.predictFcn(X) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedClassifier''. \n \nX must contain exactly 13 columns because this classifier was trained using 13 predictors. \nX must contain only predictor columns in exactly the same order and format as your training \ndata. Do not include the response column or any columns you did not import into \nClassification Learner. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
% Convert input to table
%test whether useful
%{
inputTable = array2table(trainingData, 'VariableNames', {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13', 'column_14'});

predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_14;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false];
%}

% Set up holdout validation
%cvp = cvpartition(response, 'Holdout', 0.2);
%trainingPredictors = predictors(cvp.training,:);
%trainingResponse = response(cvp.training,:);
%trainingPredictors=Ctrain;
%trainingResponse=dtrain;
%}
%�޸�ѵ���� change training set
%ʹ��ȫ��ָ�� uese all indexs
trainingPredictors=trainpredictors;
[per_n,pre_m]=size(trainingPredictors);
isCategoricalPredictor =zeros(1,pre_m);
trainingResponse=trainresponses;
trainingIsCategoricalPredictor = isCategoricalPredictor;

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationTree = fitctree(...
    trainingPredictors, ...
    trainingResponse, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 20, ...
    'Surrogate', 'off', ...
    'ClassNames', [1; 2; 3]);

% Create the result struct with predict function
treePredictFcn = @(x) predict(classificationTree, x);
validationPredictFcn = @(x) treePredictFcn(x);

% Add additional fields to the result struct

% Compute validation accuracy
%validationPredictors = predictors(cvp.test,:);
%validationResponse = response(cvp.test,:);
%validationPredictors = Ctest;
%validationResponse = dtest;
%%
%���鼯�ϺͲ��Լ��� val set, test set
%ʹ��ȫ��ָ�� ues all indexs
validationPredictors = valpredictors;
validationResponse = valresponses;

testPredictors = testpredictors;
testResponse = testresponses;

[validationPredictions, validationScores] = validationPredictFcn(validationPredictors);
correctPredictions = (validationPredictions == validationResponse);
validationAccuracy = sum(correctPredictions)/length(correctPredictions);
[testPredictions, testScores] = validationPredictFcn(testPredictors);
correctPredictions = (testPredictions == testResponse);
testAccuracy = sum(correctPredictions)/length(correctPredictions);
Micro_F=micro_average(testPredictions,testResponse);
Macro_F=Macro_average(testPredictions,testResponse);
K=Kappa(testPredictions,testResponse);
precision=Precision(testPredictions,testResponse);
end