function [] = NC_BER(watermark, image_names, block_sizes, attack)

% Define the watermark
watermark = watermark;
block_sizes = block_sizes;

% Preallocate arrays to store NC and BER values
NC = zeros(1, numel(image_names));
BER = zeros(1, numel(image_names));

% Loop through each image
for i = 1:numel(image_names)
    % Load the cover image
    cover_image = imread(image_names{i});

    if size(cover_image, 3) == 3
        cover_image = rgb2gray(cover_image);
    end

    % Embed the watermark in the cover image and extract it
    [watermarked_image, original_watermark, extracted_watermark, encrypted_watermark] = dwt_svd(watermark, cover_image, block_sizes(i), attack, 5);


    % Calculate the NC and BER
    NC(i) = nc(original_watermark, extracted_watermark);
    BER(i) = ber(original_watermark, extracted_watermark);

end

% Plot the results
figure;
subplot(2,1,1);
bar(NC);
title('Normalized Correlation');
xticklabels(image_names);
subplot(2,1,2);
bar(BER);
title('Bit Error Rate');
xticklabels(image_names);

end
