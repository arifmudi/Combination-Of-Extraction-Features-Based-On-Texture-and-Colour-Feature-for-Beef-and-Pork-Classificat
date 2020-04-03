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
I=im2double(I); %convert to double
if size(I,3)==3
    I=rgb2gray(I); %convert to grayscale if rgb
end

% figure;
% imshow(I); %display grayscale image

[m,n]=size(I); %get the size of image

%initialise variable
x=zeros(8,1);
y=zeros(8,1);
b=zeros(m,n);

%Kirsch masks
msk=zeros(3,3,8); %east, north-east, north, north-west, west, south-west, south, south-east
msk(:,:,1)=[-3 -3 5; -3 0 5; -3 -3 5]; %east
msk(:,:,2)=[-3 5 5; -3 0 5; -3 -3 -3]; %north-east
msk(:,:,3)=[5 5 5; -3 0 -3; -3 -3 -3]; %north
msk(:,:,4)=[5 5 -3; 5 0 -3; -3 -3 -3]; %north-west
msk(:,:,5)=[5 -3 -3; 5 0 -3; 5 -3 -3]; %west
msk(:,:,6)=[-3 -3 -3; 5 0 -3; 5 5 -3]; %south-west
msk(:,:,7)=[-3 -3 -3; -3 0 -3; 5 5 5]; %south
msk(:,:,8)=[-3 -3 -3; -3 0 5; -3 5 5]; %south-east

%LOOP calculation
for i=2:m-1
    for j=2:n-1
        t=1;
            for k=-1:1
                for l=-1:1
                    if (k~=0)||(l~=0)
                         if (I(i+k,j+l)-I(i,j)<0) %threshold to generate bit
                            x(t)=0;
                         else
                            x(t)=1;
                         end
                         y(t)=I(i+k,j+l)*msk(2+k,2+l,t); %apply Kirsch masks
                         t=t+1;
                    end
                end
            end
      
 [p q]= sort(y);     %sort mask output and assign 1 to the highest 3, rest 0  
 
 for t=1:8
     b(i,j)=b(i,j)+((2^(q(t)-1))*x(t)); %decimal to binary conversion
 end
        
    end
end

b=uint8(b); %convert decimal 2-d matrix to image
% figure;
% imshow(b);  %display LBP image


%LDP Histogram
Hi=imhist(b); %find histogram
H = normalize(Hi,'norm');% figure;
% bar(H); %display histogram
for hi=1:256
   if hi <=32
       FLOOP1(hi) = H(hi);
   elseif hi <= 64
       FLOOP2(hi - 32) = H(hi);
   elseif hi <= 96
       FLOOP3(hi - 64) = H(hi);
   elseif hi <= 128
       FLOOP4(hi - 96) = H(hi);
   elseif hi <= 160
       FLOOP5(hi - 128) = H(hi);
   elseif hi <= 192
       FLOOP6(hi - 160) = H(hi);
   elseif hi <= 224
       FLOOP7(hi - 192) = H(hi);
   else
       FLOOP8(hi - 224) = H(hi);
   end    
end

fL1(iter) = sum(FLOOP1);
fL2(iter) = sum(FLOOP2);
fL3(iter) = sum(FLOOP3);
fL4(iter) = sum(FLOOP4);
fL5(iter) = sum(FLOOP5);
fL6(iter) = sum(FLOOP6);
fL7(iter) = sum(FLOOP7);
fL8(iter) = sum(FLOOP8);
fal(iter) = (fL1(iter) + fL2(iter) + fL3(iter) + fL4(iter) + fL5(iter) + fL6(iter) + fL7(iter) +fL8(iter)) /8;
end

%%--------------------------------------------------------------%%
HLOOP = [fL1; fL2; fL3; fL4; fL5; fL6; fL7; fL8; fal]; 
save HLOOP.mat HLOOP;