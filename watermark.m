%% This function apply watermarking based on different methods
%  inputs: orginal image, watermark image, watermarking method, applied 
%  attack
%  Output: watermarked image, extracted watermark image considering attacks
function [watermarked_image, original_watermark, extracted_watermark, encrypted_watermark] = watermark(watermark_logo,cover_image,block_size,method,attack,param,alpha)
    switch method
        case 'DWT-SVD'
           [watermarked_image, original_watermark, extracted_watermark, encrypted_watermark] = dwt_svd(watermark_logo,cover_image,block_size,attack,param);
        otherwise
            errordlg('Please specify a method!');
    end
end