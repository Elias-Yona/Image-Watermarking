function encrypted_image = encrypt_image(image, key)
% Encrypt an image using a key

% Convert image to double precision
image = double(image);

% Create a random number generator using key
rng(key);

% Generate a random permutation of the row indices of the image
row_permutation = randperm(size(image, 1));

% Generate a random permutation of the column indices of the image
col_permutation = randperm(size(image, 2));

% Permute the rows and columns of the image using the random permutations
permuted_image = image(row_permutation, col_permutation, :);

% Add random noise to the permuted image
noise = randn(size(image)) * 20; % Choose a noise level of 20
noisy_permuted_image = permuted_image + noise;

% Return the encrypted image
encrypted_image = uint8(noisy_permuted_image);

end
