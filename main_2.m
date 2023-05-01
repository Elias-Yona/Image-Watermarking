clc
clear
close all

%% Import image
cover_image=imread('lena512.bmp');
watermark_logo=imread('cameraman.tif');

%% Example: watermark embedding and exraction  alpha=0.1 Attack: Sharpening
method = 'DWT-SVD';          % Apply 'DWT-HD-SVD Method
alpha = 0.1;
attack = 'Motion blur';   % You can choose other attacks
param = 0.5;                    % attack parameter
% watermark(cover_image, watermark_logo,method,alpha,attack,param)
[original_watermark, extracted_watermark] = dwt_svd_2(watermark_logo, cover_image, 8);
imshow(extracted_watermark);