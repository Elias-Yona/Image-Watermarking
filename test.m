% % Load the image
% img = imread('lena512.bmp');
% 
% % Define the block size
% block_size = 8;
% 
% % Pad the image if necessary
% [M,N,C] = size(img);
% M_pad = ceil(M/block_size)*block_size;
% N_pad = ceil(N/block_size)*block_size;
% img_pad = uint8(zeros(M_pad,N_pad,C));
% img_pad(1:M,1:N,:) = img;
% 
% % Extract the blocks and flatten them
% num_rows = M_pad/block_size;
% num_cols = N_pad/block_size;
% num_cells = num_rows*num_cols;
% flattened_blocks = zeros(1, num_cells*block_size^2);
% idx = 1;
% for c = 1:num_cols
%     for r = 1:num_rows
%         block = img_pad((r-1)*block_size+1:r*block_size, (c-1)*block_size+1:c*block_size, :);
%         flattened_blocks(idx:idx+block_size^2-1) = block(:);
%         idx = idx + block_size^2;
%     end
% end
% 
% % Fill the remaining cells with zeros
% if num_cells > length(flattened_blocks)/block_size^2
%     num_zeros = (num_cells - length(flattened_blocks)/block_size^2) * block_size^2;
%     flattened_blocks(end+1:end+num_zeros) = 0;
% end
% 
% % Reshape the flattened blocks into a cell array
% blocks = mat2cell(flattened_blocks, block_size*ones(1,num_rows), block_size*ones(1,num_cols));
% 
% disp(blocks);

% % Read original image
% img = imread('lena512.bmp');
% 
% % Convert image to binary
% bw_img = imbinarize(img);
% 
% % Invert binary image
% inv_bw_img = imcomplement(bw_img);
% 
% % Display original and inverted binary images side by side
% figure;
% subplot(1,2,1);
% imshow(bw_img);
% title('Binary Image');
% subplot(1,2,2);
% imshow(inv_bw_img);
% title('Inverted Binary Image');

% Load an example image
I = imread('cman.tif');

% Define a permutation key
key = randperm(numel(I));

% Encrypt the image using the permutation cipher
encrypted_image = permuteCipher(I, key);
decrypted_image = permuteDecipher(encrypted_image, key);

encrypted_arnold = encryptArnoldCat(I, 2);
decrypted_arnold = decryptArnoldCat(encrypted_arnold, 2);

encrypt_baker = encryptBakerMap(I, 2, 2);


Display the original and encrypted images side-by-side
title('Original Image');

subplot(4,2,1);
imshow(encrypted_image);
title('Encrypted Image');
subplot(4,2,2);
imshow(decrypted_image);
title('Decrypted Image');
subplot(4,2,3);
imshow(encrypted_arnold);
title('Encrypted Arnold Image');
subplot(4,2,4);
imshow(decrypted_arnold);
title('Decrypted Arnold Image');
subplot(4,2,5);
imshow(encrypt_baker);
title('Encrypt Baker Image');
% subplot(4,2,6);
% imshow(decrypt_logistic);
% title('Decrypt Logistic Image');
