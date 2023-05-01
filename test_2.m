% Read the input image
image = imread('lena512.bmp');

% Generate a random key
key = [10 20];

% Encrypt the image using 2D mapping
encrypted_image = mappingEncrypt(image, key);

% Display the encrypted image
imshow(encrypted_image);



function encrypted_image = mappingEncrypt(image, key)
% This function encrypts an image using 2D mapping
% Inputs:
%   - image: the image to be encrypted
%   - key: the encryption key
% Output:
%   - encrypted_image: the encrypted image

% Check input arguments
if nargin < 2
    error('Not enough input arguments.');
end

% Ensure the key is valid
if numel(key) ~= 2
    error('Invalid key.');
end

% Convert image to double precision
image = im2double(image);

% Get image dimensions
[M, N] = size(image);

% Create the Arnold cat map matrix
A = [1, 1; 1, 2];

% Generate the encryption sequence using the Arnold cat map
sequence = zeros(M*N, 2);
sequence(1,:) = key;
for i = 2:M*N
    sequence(i,:) = mod(A*sequence(i-1,:)', [M N]);
end

% Map pixels to new locations
encrypted_image = zeros(M, N);
for i = 1:M*N
    old_pos = sequence(i,:);
    new_pos = mod(A*old_pos', [M N]);
    encrypted_image(new_pos(1)+1, new_pos(2)+1) = image(old_pos(1)+1, old_pos(2)+1);
end

% Convert encrypted image to uint8
encrypted_image = im2uint8(encrypted_image);

end
