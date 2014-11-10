function [ frequencies ] = ifft_2d( signal )
%IFFT_2D A better ifft; shifts to the center of the image first

frequencies = fftshift(ifft2(ifftshift(signal)));

end

