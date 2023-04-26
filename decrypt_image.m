function decrypted_image = decrypt_image(encrypted_image, key)
    % Decrypt an encrypted image using a key
    
    % Convert image to double precision
    encrypted_image = double(encrypted_image);
    
    % Create a random number generator using key
    rng(key);
    
    % Generate the same random permutations of the row and column indices as
    % in the encryption process
    row_permutation = randperm(size(encrypted_image, 1));
    col_permutation = randperm(size(encrypted_image, 2));
    
    % Invert the row and column permutations
    inv_row_permutation(row_permutation) = 1:length(row_permutation);
    inv_col_permutation(col_permutation) = 1:length(col_permutation);
    
    % Un-permute the rows and columns of the encrypted image using the
    % inverted permutations
    unpermuted_image = encrypted_image(inv_row_permutation, inv_col_permutation, :);
    
    % Remove the random noise from the un-permuted image
    denoised_unpermuted_image = unpermuted_image - randn(size(encrypted_image)) * 20; % Choose the same noise level of 20 as in the encryption process
    
    % Truncate the denoised pixel values to the range [0, 255]
    denoised_unpermuted_image(denoised_unpermuted_image < 0) = 0;
    denoised_unpermuted_image(denoised_unpermuted_image > 255) = 255;
    
    % Return the decrypted image
    decrypted_image = uint8(denoised_unpermuted_image);

end

