function K_decrypted = decryptArnoldCat(K, iterations)
    % Determine the size of the input array
    N = sqrt(length(K));
    if N ~= round(N)
        error('Input array is not of the expected size');
    end
    
    % Initialize Arnold Cat Map parameters
    a = 2;
    b = 3;
    
    % Perform the inverse Arnold Cat Map transformation
    x = reshape(K, [N, N]);
    y = x;
    for i = 1:iterations
        y = mod(y + b*x, N);
        x = mod(x + a*y, N);
    end
    
    % Convert the transformed data to a column vector
    K_decrypted = reshape(x, [], 1);
end
