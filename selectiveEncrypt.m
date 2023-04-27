function encrypted_image = selectiveEncrypt(image, key)
    % Convert input image to grayscale
    if size(image, 3) == 3
        image = rgb2gray(image);
    end
    
    % Get the binary representation of the image
    image_bin = imbinarize(image);

    % Encrypt the binary image
    encrypted_image = false(size(image_bin));
    for i = 1:numel(image_bin)
        bit = image_bin(i);
        encrypted_image(i) = bitxor(bit, floor(bitshift(key,-mod(i-1,8))));
    end
    
    % Convert the encrypted binary image to uint8
    encrypted_image = uint8(255 * encrypted_image);
end

