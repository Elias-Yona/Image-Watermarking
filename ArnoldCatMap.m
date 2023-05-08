classdef ArnoldCatMap
    properties
        image
        iterations
    end
    methods
        function obj = ArnoldCatMap(image, iterations)
            obj.iterations = iterations;
            obj.image = image;
        end

        function encrypted_image = encryptImage(obj)
            % Encrypt image

            [rown, coln, channels] = size(obj.image);
        
            for inc=1:obj.iterations   
                newimage=zeros(rown, coln, channels);
                for row=1:rown
                    for col=1:coln
                        newcoord=[1, 1; 1, 2]*[row, col]';
                        newrow=mod(newcoord(1) - 1, rown) + 1;
                        newcol=mod(newcoord(2) - 1, coln) + 1;
                        newimage(newrow,newcol,:)=obj.image(row,col,:);
                    end
                end
                obj.image=newimage;
            end
       
            encrypted_image=mat2gray(obj.image);
        end

        function decrypted_image = decryptImage(obj, encrypted_image)
            % Decrypt image

            encrypted_image = im2uint8(encrypted_image);
            [rown, coln, channels] = size(encrypted_image);
        
            for inc=1:obj.iterations   
                origimage=zeros(rown, coln, channels);
                for row=1:rown
                    for col=1:coln
                        origcoord=[2, -1; -1, 1]*[row, col]';
                        origrow=mod(origcoord(1) - 1, rown) + 1;
                        origcol=mod(origcoord(2) - 1, coln) + 1;
                        origimage(origrow,origcol,:)=encrypted_image(row,col,:);
                    end
                end
                encrypted_image = origimage;
            end
     
            decrypted_image = encrypted_image;
        end
    end
end