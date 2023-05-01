function encrypted_image = encryptArnoldCat(img, key)
    [rown,coln]=size(img);
    for inc=1:key
        for row=1:rown
            for col=1:coln
                
                nrowp = row;
                ncolp=col;
                for ite=1:inc
                    newcord =[1 1;1 2]*[nrowp ncolp]';
                    nrowp=newcord(1);
                    ncolp=newcord(2);
                end
                newim(row,col)=img((mod(nrowp,rown)+1),(mod(ncolp,coln)+1));
                
            end
        end
    end
    encrypted_image = newim;
end

function encrypted_image = encrypt(img)
   % applies Arnold's Cat Map to the image Y to produce image X

    p = size(img,1);      % get the number of pixels on each side
    X = zeros(size(img)); % make space for X (all zeros to start)
    for i = 1:p         % loop through all the pixels
       for j = 1:p
           newi = mod(((i-1) + (j-1)),p) + 1;     % get new i coord (m+n) mod p
           newj = mod(((i-1) + 2*(j-1)),p) + 1;   % get new j coord (m+2n) mod p
           X(newi,newj,:) = img(i,j,:);
       end
    end
    X = uint8(X);   % this may have to be adjusted depending on the type of image
    encrypted_image = X;
end
