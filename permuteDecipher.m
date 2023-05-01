function decrypted_image = permuteDecipher(image, key)
    % This function decrypts an image that was encrypted using a permutation cipher
    % Inputs:
    %   - image: the encrypted image to be decrypted
    %   - key: the permutation key used for encryption
    % Output:
    %   - decrypted_image: the decrypted image
    
    % Check input arguments
    if nargin < 2
        error('Not enough input arguments.');
    end
    
    % Convert image to a vector
    image_vector = image(:);
    
    % Calculate the size of the image vector
    n = numel(image_vector);
    
    % Check that the key is valid
    if length(key) ~= n
        error('Invalid key length.');
    elseif ~isequal(sort(key), 1:n)
        error('Invalid key.');
    end
    
    % Invert the key to get the decryption key
    decryption_key(key) = 1:n;
    
    % Permute the image vector using the decryption key
    decrypted_vector = image_vector(decryption_key);
    
    % Reshape the decrypted vector to the original image size
    decrypted_image = reshape(decrypted_vector, size(image));
end
