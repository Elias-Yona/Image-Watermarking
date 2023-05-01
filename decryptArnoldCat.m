function decrypted_image = decryptArnoldCat(img, key)
    [rown, coln] = size(img);
    inv_it_count = key;
    inv_img = img;
    for inc = 1:inv_it_count
        for row = 1:rown
            for col = 1:coln
                nrowp = row;
                ncolp = col;
                for ite = 1:inc
                    newcord = [1 1; 1 2] * [nrowp; ncolp];
                    nrowp = newcord(1);
                    ncolp = newcord(2);
                end
                inv_img(mod(nrowp - 1, rown) + 1, mod(ncolp - 1, coln) + 1) = img(row, col);
            end
        end
    end
    decrypted_image = inv_img;
end
