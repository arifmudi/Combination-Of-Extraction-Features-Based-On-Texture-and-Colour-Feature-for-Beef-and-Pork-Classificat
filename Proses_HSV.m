clear all
close all
Daging = 'DataSapiBabi';
FileNames = dir(fullfile(Daging, '*.jpg'));
TotalData = numel (FileNames);

for iter=1:TotalData
FullName = fullfile (Daging, FileNames(iter).name);

% pre-processing
I1=imread(FullName); %input image
% imshow(I); %display input image
I = imresize(I1,[400 400]);

NilaiHSV = rgb2hsv(I);
H = NilaiHSV(:,:,1);
S = NilaiHSV(:,:,2);
V = NilaiHSV(:,:,3);

NilaiH(iter) = mean(mean(H));
NilaiS(iter) = mean(mean(S));
NilaiV(iter) = mean(mean(V));
end

Hasil_HSV = [NilaiH; NilaiS; NilaiV];
save Hasil_HSV.mat Hasil_HSV;