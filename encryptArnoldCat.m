function K = encryptArnoldCat(x, iterations)
    % Initialize the point
    p = 0;
    q = 0;

    % Perform the specified number of iterations of the Arnold Cat map
    for i = 1:iterations
        [p, ~] = cat_map(p, q);
        [q, ~] = cat_map(q, p);
    end
    
    % Combine the transformed points into a single array
    data = [p;q];
    
    % Convert data to a column vector
    data = reshape(data, [], 1);
    
    % Return the encrypted data
    K = mod(data, 256);
end

% Helper function to compute the Arnold Cat map transformation
function [p_new, q_new] = cat_map(p, q)
    p_new = mod(p + q, 256);
    q_new = mod(p + 2 * q, 256);
end

