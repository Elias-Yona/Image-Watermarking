classdef SelectiveEncrypt
    properties
        blocks
        blocks_to_encrypt
        key
    end

    methods
        function obj = SelectiveEncrypt(blocks, blocks_to_encrypt, key)

            obj.blocks_to_encrypt = blocks_to_encrypt;
            obj.blocks = blocks;
            obj.key = key;
        end

        function encrypted_image = encryptImage(obj)
            % Perform selectiv encryption
            
            for i = 1:length(obj.blocks_to_encrypt)
                % Get the indices of the block to encrypt
                row = obj.blocks_to_encrypt{i}(1);
                col = obj.blocks_to_encrypt{i}(2);
                
                % Get the block
                block = obj.blocks(row, col);
                
                % Perform the encryption operation (for example, using bitxor)
                encrypted_block = bitxor(block, obj.key);
                
                % Replace the original block with the encrypted block
                obj.blocks(row, col) = encrypted_block;

                encrypted_image = obj.blocks;
            end
        end
    end
end


