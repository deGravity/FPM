function [ images, apertures ] = simple_fpm_simulation( object )
%SIMPLE_FPM_SIMULATION Summary of this function goes here
%   Detailed explanation goes here

width = size(object, 1);
height = size(object, 2);

object_fft = fft_2d(object);

% Initialize images and apertures - there must be a better way to do this
images = [];
apertures = [];

% Use a circular aperture that is 1/5 of the smallest object dimension
% Slowly spiral outwards from the center
radius =  min(width, height)/10;

for theta = linspace(0, 12*pi, 120) % Ugly - do this better
    r = radius*theta / (4 * pi);
    aperture = complex(+circ(r*cos(theta), r*sin(theta),radius,width,height));
    apertures = cat(3,apertures,aperture); % Append next aperture to the list
    image = abs( ifft_2d( object_fft .* aperture ) );
    % Simulate a low res image
    image = imresize(image, 1/2);
    image = imresize(image, 2);
    images = cat(3, images, image ); % Append next image to the list
end

end

