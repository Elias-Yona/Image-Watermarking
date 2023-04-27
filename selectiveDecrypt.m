function decrypted_image = selectiveDecrypt(encrypted_image, key)
    % Convert input image to binary
    encrypted_image_bin = encrypted_image;

    % Decrypt the binary image
    decrypted_image_bin = false(size(encrypted_image_bin));
    for i = 1:numel(encrypted_image_bin)
        bit_encrypted = encrypted_image_bin(i);
        bit_decrypted = bitxor(bit_encrypted, floor(bitshift(key,-mod(i-1,8))));
        decrypted_image_bin(i) = bit_decrypted;
    end
    
    % Convert the decrypted binary image to uint8
    decrypted_image = uint8(255 * decrypted_image_bin);
end
