%% This function apply watermarking based on different methods
%  inputs: orginal image, watermark image, watermarking method, applied 
%  attack
%  Output: watermarked image, extracted watermark image considering attacks
function [watermarked_image, extracted_watermark, encrypted_image] = watermark(cover_image,watermark_logo,method,alpha,attack,param)
    switch method
        case 'DWT-SVD'
            [watermarked_image, extracted_watermark, encrypted_image] = dwt_svd(cover_image,watermark_logo,alpha,attack,param);
        otherwise
            errordlg('Please specify a method!');
    end
end