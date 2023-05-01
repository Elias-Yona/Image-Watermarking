%% This function plots normlized correlation vs alpha
function [NC] = NC_alpha(watermark_logo,cover_image,block_size,method,alpha,attacks,params)

NC = zeros(length(attacks), length(alpha));
for j=1:length(attacks)
    attack = string(attacks(j));
    param = params(j);
    for i=1:length(alpha)
        [watermarked_image, original_watermark, extracted_watermark, encrypted_image] = watermark(watermark_logo,cover_image,block_size,method,attack,param,alpha(i));
        NC(j,i) = nc(watermark_logo,extracted_watermark);
    end
end
end