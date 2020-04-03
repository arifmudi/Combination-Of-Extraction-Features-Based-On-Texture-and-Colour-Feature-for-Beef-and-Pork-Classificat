clear
load('Hasil_HSV.mat')
load('feature.mat')
load('HLOOP.mat')
load persen.mat
HSV = Hasil_HSV';
LOOP = HLOOP';
feature = [];
feature = [Hasil_HSV; HLOOP];
feature = feature';
persen = persen;
persentase = round(persen/100 * size(target,1)); 

XTrain_Combine = [];
XTrain_hsv = [];
XTrain_loop = [];

Ytrain_Combine = [];
Ytrain_hsv = [];
Ytrain_loop = [];

XTest_combine = [];
XTest_hsv = [];
XTest_loop = [];

YTest_combine = [];
YTest_hsv = [];
YTest_loop = [];

for n=1:size(target,1)
   if n <= persentase
       XTrain_Combine(n,:) = feature(n,:);
       XTrain_hsv(n,:) = HSV(n,:);
       XTrain_loop(n,:) = LOOP(n,:);
       
       Ytrain_Combine(n,1) = target(n);
       Ytrain_hsv (n,1) = target(n);
       Ytrain_loop (n,1) = target(n);
  else
        XTest_combine(n-persentase,:) = feature(n,:);
        XTest_hsv(n-persentase,:) = HSV(n,:);
        XTest_loop(n-persentase,:) = LOOP(n,:);

        YTest_combine(n-persentase,1) = target(n);
        YTest_hsv(n-persentase,1) = target(n);
        YTest_loop(n-persentase,1) = target(n);
   end
    
end
save HasilPembagianData.mat XTrain_Combine XTrain_hsv XTrain_loop Ytrain_Combine Ytrain_hsv ...
    Ytrain_loop XTest_combine XTest_hsv XTest_loop YTest_combine YTest_hsv YTest_loop;