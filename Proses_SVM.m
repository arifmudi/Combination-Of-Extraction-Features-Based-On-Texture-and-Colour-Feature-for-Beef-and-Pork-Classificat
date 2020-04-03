clear;
load('HasilPembagianData.mat')

%===============================================
%     Calculating mean and standard deviation
%===============================================
mean_of_dimension1 = mean(XTrain_Combine);
std_deviation1 = std(XTrain_Combine, 1);

mean_of_dimension2 = mean(XTrain_hsv);
std_deviation2 = std(XTrain_hsv, 1);

mean_of_dimension3 = mean(XTrain_loop);
std_deviation3 = std(XTrain_loop, 1);
%===============================================
%               Normalising Data
%===============================================
XTrain_Combine = normalise(XTrain_Combine, std_deviation1, mean_of_dimension1); % normalising training data 
XTest_combine = normalise(XTest_combine, std_deviation1, mean_of_dimension1);   % normalising testing data

XTrain_hsv = normalise(XTrain_hsv, std_deviation2, mean_of_dimension2); % normalising training data 
XTest_hsv = normalise(XTest_hsv, std_deviation2, mean_of_dimension2);   % normalising testing data

XTrain_loop = normalise(XTrain_loop, std_deviation3, mean_of_dimension3); % normalising training data 
XTest_loop = normalise(XTest_loop, std_deviation3, mean_of_dimension3);   % normalising testing data


C = 10;
model1 = svmTrain(XTrain_Combine, Ytrain_Combine, C, @linearKernel);
model2 = svmTrain(XTrain_hsv, Ytrain_hsv, C, @linearKernel);
model3 = svmTrain(XTrain_loop, Ytrain_loop, C, @linearKernel);

p1 = svmPredict(model1, XTest_combine);
p2 = svmPredict(model2, XTest_hsv);
p3 = svmPredict(model3, XTest_loop);


CM1 = confusionmat(YTest_combine,p1);
CMCombinasi = CM1;
CM2 = confusionmat(YTest_hsv,p2);
CMHSV = CM2;
CM3 = confusionmat(YTest_loop,p3);
CMLOOP = CM3;

fprintf(' Accuracy combine: %f\n', mean(double(p1 == YTest_combine)) * 100);
fprintf(' Accuracy HSV: %f\n', mean(double(p2 == YTest_hsv)) * 100);
fprintf(' Accuracy LOOP: %f\n', mean(double(p3 == YTest_loop)) * 100);

Recall1 = CM1(1,1)/(CM1(1,1) + CM1(2,1));
Recall2 = CM2(1,1)/(CM2(1,1) + CM2(2,1));
Recall3 = CM3(1,1)/(CM3(1,1) + CM3(2,1));
fprintf(' Recall combine: %f\n', Recall1 * 100);
fprintf(' Recall HSV: %f\n', Recall2 * 100);
fprintf(' Recall LOOP: %f\n', Recall3 * 100);

Precision1 = CM1(1,1) / (CM1(1,1) + CM1(1,2));
Precision2 = CM2(1,1) / (CM2(1,1) + CM2(1,2));
Precision3 = CM3(1,1) / (CM3(1,1) + CM3(1,2));
fprintf(' Precision combine: %f\n', Precision1 * 100);
fprintf(' Precision HSV: %f\n', Precision2 * 100);
fprintf(' Precision LOOP: %f\n', Precision3 * 100);