function [ frequencies ] = fft_2d( signal )
%FFT_2D A better fft - it shifts the origin to the center of the image
%before performing the fft.

frequencies = ifftshift(fft2(fftshift(signal)));

end

