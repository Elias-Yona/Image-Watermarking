%% This function calculates PSNR of orginal image and watermarked image
%  PSNR is used to evaluated robustness of methods
function [PSNR] = PSNR_alpha(cover_image,watermark_logo,method,alpha,attacks,params)

PSNR = zeros(length(attacks), length(alpha));
for j=1:length(attacks)
    attack = string(attacks(j));
    param = params(j);
    for i=1:length(alpha)
        [watermarked_image, original_watermark, extracted_watermark, encrypted_image] = watermark(watermark_logo,cover_image,block_size,method,attack,param,alpha(i));
        PSNR(j,i) = psnr(watermarked_image, cover_image);
    end
end
end