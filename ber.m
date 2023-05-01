function ber = ber(original_watermark, extracted_watermark)
    % Calculate the bit error rate (BER) of the extracted watermark
    % Inputs:
    %   - original_watermark: the original watermark
    %   - extracted_watermark: the extracted watermark
    % Output:
    %   - ber: the bit error rate
    
    % Check input arguments
    if nargin < 2
        error('Not enough input arguments.');
    end
    
    % Ensure that the original watermark and the extracted watermark have the same size
    assert(numel(original_watermark) == numel(extracted_watermark), 'Watermark sizes do not match.');
    
    % Calculate the number of bit errors
    num_bit_errors = sum(original_watermark(:) ~= extracted_watermark(:));
    
    % Calculate the bit error rate
    ber = num_bit_errors / numel(original_watermark);
end
