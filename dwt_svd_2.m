function [watermarked_image, original_watermark, extracted_watermark, encrypted_watermark] = dwt_svd_2(watermark_logo, cover_image, block_size)
    %% Embedding

    %% Step 1: % Image partitioning
    
    original_watermark = watermark_logo;
    % Block size
    block_size = block_size;

    % Number of blocks
    num_blocks = numel(watermark_logo);

    % pad the image so that its dimensions are a multiple of block_size
    padded_size = block_size * ceil(size(cover_image) / block_size);
    padded_img = padarray(cover_image, padded_size - size(cover_image), 0, 'post');

    % Calculate the number of rows and columns needed to extract the desired number of blocks
    num_rows = size(padded_img, 1) / block_size;
    num_cols = size(padded_img, 2) / block_size;
    
    % Extract nxn blocks from the image
    blocks = cell(num_rows*num_cols, 1);
    idx = 1;
    for c = 1:num_cols
        for r = 1:num_rows
            block = padded_img((r-1)*block_size+1:r*block_size, (c-1)*block_size+1:c*block_size, :);
            blocks{idx} = block;
            idx = idx + 1;
        end
    end
    
    % Check if the number of extracted blocks is less than num_blocks
    if num_blocks > numel(blocks)
        % Calculate the number of remaining blocks needed
        num_remaining = num_blocks - numel(blocks);
        
        % Add remaining blocks to the blocks cell array
        for i = 1:num_remaining
            blocks{numel(blocks)+1} = zeros(block_size);
        end
    end
    
    % Convert the cell array of blocks to a matrix
    flattened_blocks = zeros(numel(blocks)*block_size^2, 1);
    for i = 1:numel(blocks)
        block = blocks{i};
        flattened_blocks((i-1)*block_size^2+1:i*block_size^2) = block(:);
    end
    
    % Reshape the flattened blocks into a matrix
    blocks = reshape(flattened_blocks, block_size, block_size, []);
   

    %% Step 2: Apply SVD to each block Bi
    for i = 1:num_blocks
        block = blocks(:,:,i);
        [U,S,V] = svd(block);
        blocks(:,:,i) = S;
    end


    %% Step 3: Generate matrices temp and M

    % Declare a matrix 'temp' to store the first singular value of each block
    temp = zeros(num_blocks, 1);

    % Loop through each block Bi
    for i = 1:num_blocks
        % Apply SVD to the block Bi
        block = blocks(:,:,i);
        
        % Extract the diagonal matrix Si
        Si = diag(block);
        
        % Store the first singular value of Bi in 'temp'
        temp(i) = Si(1,1);
    end

    % Create a matrix M to store generated bits
    M = zeros(num_blocks, 1);
    
    % Loop through temp rowwise and generate bits
    for i = 1:size(temp, 1)-1
        if temp(i) >= temp(i+1)
            M(i) = 1;
        else
            M(i) = 0;
        end
    end


    %% Step 4: Read Watermark image and perform Selective Encryption to binary watermark image

    % TODO: Use other encryption technique e.g selective encryption
    key = randperm(numel(watermark_logo));
    encrypted_watermark = permuteCipher(watermark_logo, key);

    % Convert the grayscale image to binary using Otsu's thresholding method.
    binary_watermark = imbinarize(encrypted_watermark, 'adaptive');
 

    %% Step 5: Perform logical XOR operation on matrix M and the encrypted watermark

    % Reshape M to a 256x255 matrix
    [w_rows, w_cols] = size(binary_watermark);

    M_reshaped = reshape(M, w_rows, w_cols);

    x = xor(M_reshaped, binary_watermark);


    %% Step 6: Perform lossless encryption on x using Arnold Cat Map to get a master share K

    % TODO: Arnold Cat Map encryption is good but decryption isn't lossless
    % iterations = 10;
    % K = encryptArnoldCat(x, iterations);
    [M,N,nc]=size(x);
    if mod(M,2)==1
        M=M+1;
    end
    if mod(N,2)==1
        N=N+1;
    end
    I=imresize(x,[M N]);

    rounds=2;
    for i=1:nc
        [I_enc(:,:,i),SX{i}]=fibonacciMatrixEncrypt(I(:,:,i),rounds);
    end

    K = I_enc;

    encrypted_watermark = K;

    watermarked_image = Attacks(encrypted_watermark,attack,param);


    %% Extraction

    %% step 4: Perform lossless decryption on master share K using Arnold cat map

    % x = decryptArnoldCat(K, iterations);
    for i=1:nc
        I_dec(:,:,i)=fibonacciMatrixDecrypt(K(:,:,i),SX{i});
    end
    x = I_dec;


    %% step 5: : Perform logical XOR operation on the matrix M and decrypted master share x

    encrypted_watermark = xor(M_reshaped, x);
    decrypted_watermark = permuteDecipher(encrypted_watermark, key);
    extracted_watermark = decrypted_watermark;
end
