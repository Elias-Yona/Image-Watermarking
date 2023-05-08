classdef ImageHandler
    properties
        filename
    end

    methods
        function obj = ImageHandler(filename)
            obj.filename = filename;
        end

        function image = readImage(obj)
            % Read image into memory

            image = imread(obj.filename);
        end

        function [padded_image, pad_h, pad_w] = padImage(obj, image, block_size)
            % Add padding to an image to make it a square

            [h, w, ~] = size(image);

            pad_h = mod(block_size - mod(h, block_size), block_size);
            pad_w = mod(block_size - mod(w, block_size), block_size);
            padded_image = padarray(image, [pad_h, pad_w], 0, 'post');
        end

        function [unpadded_image] = removePadding(obj,padded_image, pad_h, pad_w)
            % Remove padding from an image
        
            [h, w, ~] = size(padded_image);
            unpadded_image = padded_image(1:h-pad_h, 1:w-pad_w, :);
        end

        function [blocks, image_block, offset] = divideImage(obj, image, block_size, number_of_blocks)
            % Divide an image into n x n blocks
            
            [h, w, ~] = size(image);
            n = block_size;

            required_num_pixels = number_of_blocks * block_size * block_size;
            image_row = image(:);

            if required_num_pixels < numel(image)
                error("Number of blocks is too few");
            end
            
            new_img_width = ceil(sqrt(required_num_pixels));
            new_img_height = ceil(sqrt(required_num_pixels));

            new_img = ones(1,new_img_height*new_img_width);

            for i=1:length(image_row)
                new_img(i) = image_row(i);
            end    

            % disp(new_img_width);
            % disp(new_img_height);

            new_img = reshape(new_img, [new_img_width, new_img_height]);
            
            [new_img, pad_h, pad_w] = obj.padImage(new_img, n);

            [new_h, new_w] = size(new_img);    
            offset = (new_h * new_h) - required_num_pixels;

            image_block = uint8(new_img);
            blocks = {};

            for i = 1:n:size(new_img,1)-n+1
                for j = 1:n:size(new_img,2)-n+1
                    block = new_img(i:i+n-1,j:j+n-1);
                    blocks{end+1} = block;
                end
            end
        end

        function num_bits = getNumBits(obj)
            % Get the total number of bits in an image
            image = obj.readImage();
            bits_per_pixel = ceil(log2(double(intmax(class(image)) + 1)));
            num_bits = numel(image) * bits_per_pixel;
        end
    end
end