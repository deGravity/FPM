function [ images, pupil_data ] = epry_simulation( object, overlap, num_x, num_y, aberrations )
%EPRY_SIMULATION Simulate fpm with aberations in the lens.
%   object - The complex image to sample
%   overlap - The percentage overlap between adjacent samples
%   num_x - The number of samples in the x direction
%   num_y - The number of samples in the y direction
%   aberrations - A vector of coefficients for Zernike polynomal
%   aberrations of the lens.

addpath('../util');

[height, width] = size(object);

pupil_data = pupil_locations(width, height, overlap, num_x, num_y);
pupils = build_pupils(pupil_data, aberrations);

transform = fft_image(object);
images = [];
for i=1:size(pupils,3)
    image = ifft_image( pupils(:,:,i) .* transform );
    image = image .* conj(image);
    images = cat(3, images, image);
end

end

