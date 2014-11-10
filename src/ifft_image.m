function [ image ] = ifft_image( transform )
%IFFT_IMAGE An ifft for images. Treats the center of the image as (0,0).
image = fftshift(ifft2(ifftshift(transform)));
end

