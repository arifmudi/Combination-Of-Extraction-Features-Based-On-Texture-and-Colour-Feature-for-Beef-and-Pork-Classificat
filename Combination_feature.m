clc;clear;
load('HasilEkstraksiGLCm.mat')
load('HLOOP.mat')
load('Hasil_HSV.mat')

LOOP = HLOOP;

feature = [GLCM; LOOP];
feature = feature';
target = zeros(400,1);


fiturPembanding = [GLCM; Hasil_HSV];
Targer_pembanding = [];
for i=1:400
    if mod(i,2) == 1
        target(i) = 1;
        Targer_pembanding(i,:) = [1;0];
    else
        target(i) = 0;
        Targer_pembanding(i,:) = [0;1];
    end
end

save feature.mat feature target fiturPembanding Targer_pembanding;