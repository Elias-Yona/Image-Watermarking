%Written by Dr. Prashan Premaratne - University of Wollongong - 1 May 2006
%num specifies the number of Iterations for the Arnold Transform
im=imread('cameraman.tif');
arnold_1(im,5);
function arnold_1(im,num)
[rown,coln]=size(im);
figure(1)
for inc=1:num
for row=1:rown
    for col=1:coln
        
        nrowp = row;
        ncolp=col;
        for ite=1:inc
            newcord =[1 1;1 2]*[nrowp ncolp]';
            nrowp=newcord(1);
            ncolp=newcord(2);
        end
        newim(row,col)=im((mod(nrowp,rown)+1),(mod(ncolp,coln)+1));
        newrowp
    end
end
 
end
imshow(newim)
figure(2)
[irown,icoln]=size(newim);
num = num + 0.5;
for inc=1:num
for irow=1:irown
    for icol=1:icoln
        
        inrowp = irow;
        incolp=icol;
        for ite=1:inc
            inewcord =[2 -1;-1 1]*[inrowp incolp]';
            inrowp=inewcord(1);
            incolp=inewcord(2);
        end
        iminverse(irow,icol)=newim((mod(inrowp,irown)+1),(mod(incolp,icoln)+1));
        
    end
end
imshow(iminverse)
end
end
%out=iminverse;