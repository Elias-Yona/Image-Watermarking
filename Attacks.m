%% This function applies attacks on images
%  Input: image, attack type, attack parameters (different for each attack)
function [watermarked_image] = Attacks(watermarked_image,attack,param)
    switch attack
        case 'No Attack'
        case 'Median'
            watermarked_image = medianAttack(watermarked_image,param);
        case 'Gaussian noise'
            watermarked_image = noiseGauss(watermarked_image,param);
        case 'Salt and pepper noise'
            watermarked_image = noiseSaltPepper(watermarked_image);
        case 'Speckle noise'
            watermarked_image = noiseSpeckle(watermarked_image);
        case 'Sharpening attack'
            watermarked_image = sharpenAttack(watermarked_image,param);
        case 'Rotating attack'
            watermarked_image = rotatAttack(watermarked_image);
        case 'Motion blur'
            watermarked_image = motionAttack(watermarked_image);
        case 'Average filter'
            watermarked_image = averageFilter(watermarked_image);
        case 'JPEG2000 compression'
            watermarked_image = jp2Attack(watermarked_image,param);
        case 'JPEG compression'
            watermarked_image = jpegAttack(watermarked_image,param);
        case 'Gaussian low-pass filter'
            watermarked_image = GlowpassFilter(watermarked_image,param);
        case 'Histogram equalization'
            watermarked_image = histAttack(watermarked_image);
        case 'Rescaling (0.25)'
            watermarked_image = rescaleAttack(watermarked_image);
        case 'Rescaling (4)'
            watermarked_image = rescale4Attack(watermarked_image);
        case 'Crop attack'
            watermarked_image = cropAttack(watermarked_image);
        otherwise
            errordlg('Please specify attack!');
    end
end

