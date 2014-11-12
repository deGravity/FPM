function [ transform ] = fft_image( image )
%FFT_IMAGE An fft for images. Treats the center of the image as (0,0).
%transform = ifftshift(fft2(fftshift(image)));
%transform = fft2(fftshift(image));
transform = fft(image);
end

