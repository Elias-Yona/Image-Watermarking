%% This function calculates the Structural Similarity Index (SSIM) for different alphas
%  SSIM compares the similarity of watermarked image and orginal image

function [SSIM] = SSIM_alpha(cover_image,watermark_logo,method,alpha,attacks,params)

SSIM = zeros(length(attacks), length(alpha));
for j=1:length(attacks)
    attack = string(attacks(j));
    param = params(j);
    for i=1:length(alpha)
        [watermarked_image, original_watermark, extracted_watermark, encrypted_image] = watermark(watermark_logo,cover_image,block_size,method,attack,param,alpha(i));
        SSIM(j,i) = ssim(watermarked_image, cover_image);
    end
end
end