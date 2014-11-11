function [ image ] = ifft_image( transform )
%IFFT_IMAGE An ifft for images. Treats the center of the image as (0,0).
image = ifftshift(ifft2(fftshift(transform)));
%image = ifftshift(ifft2(transform));
end

