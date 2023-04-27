function [encrypted_watermark, decrypted_watermark, watermarked_image] = dwt_svd_2(watermark_logo, cover_image)
   % Load host/cover image A and watermark image W
    A = cover_image;
    W = watermark_logo;
    
    % Set block size and calculate number of blocks N
    block_size = 8;
    N = numel(W)*8; % total number of bits in watermark
    
    % Partition host/cover image A into non-overlapping blocks Bi
    B = mat2cell(A, block_size*ones(1,size(A,1)/block_size), block_size*ones(1,size(A,2)/block_size));
    
    % Initialize matrices
    M = false(N,1);
    temp = zeros(N,1);
    
    % Loop over each block Bi and perform SVD
    for i = 1:numel(B)
        [U,S,V] = svd(double(B{i}));
        s = diag(S);
        
        % Store first singular value in temp
        temp(i) = s(1);
    end
    
    % Generate matrix M using temp according to Algorithm 1
    for i = 1:N-1
        if temp(i) >= temp(i+1)
            M(i) = true;
        end
    end
    
    % Read watermark image and perform selective encryption
    key = 1;
    W_encrypted = selectiveEncrypt(W, key);

    % Generate matrix X using M and W_encrypted according to Algorithm 1
    X = false(N, 8);
    k = 1;
    for i = 1:N-1
        if temp(i) >= temp(i+1)
            for j = 1:8
                X(i,j) = W_encrypted(k);
                k = mod(k, numel(W_encrypted)) + 1;
            end
        end
    end

    % Perform lossless encryption using Arnold Cat Map
    X_1D = reshape(X', [], 1);
    K = encryptArnoldCat(X_1D, 10);
    
    % Reshape encrypted watermark to matrix form
    % num_cols = sum(M);
    num_cols = size(X, 16);
    num_rows = ceil(N / num_cols);
    K_2D = uint8(reshape(K, [], num_cols) * 255);
    
    % Plot the encrypted watermark and the unencrypted watermark
    % Decrypt the watermark
    K_decrypted_1D = decryptArnoldCat(K,10);
    K_decrypted = reshape(K_decrypted_1D, size(X,2), [])';
    
    % Decrypt the selective encryption
    W_decrypted = selectiveDecrypt(W_encrypted, key);

    decrypted_watermark = W_decrypted;
    encrypted_watermark = W_encrypted;
    watermarked_image = Attacks(K_decrypted,attack,param);
end
