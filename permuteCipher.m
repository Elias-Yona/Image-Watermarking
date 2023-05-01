function encrypted_image = permuteCipher(image, key)
    % This function encrypts an image using a permutation cipher
    % Inputs:
    %   - image: the image to be encrypted
    %   - key: the permutation key
    % Output:
    %   - encrypted_image: the encrypted image
    
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
    
    % Permute the image vector using the key
    encrypted_vector = image_vector(key);
    
    % Reshape the encrypted vector to the original image size
    encrypted_image = reshape(encrypted_vector, size(image));
end
