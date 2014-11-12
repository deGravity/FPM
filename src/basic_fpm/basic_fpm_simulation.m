function images = basic_fpm_simulation( object, low_x_res, low_y_res, x_increment, y_increment, pupil )
%BASIC_FPM_SIMULATION A very basic fpm simulation
%   object - The complex image function to sample.
%   low_x_res - The x resolution of the output images
%   low_y_res - The y resolution of the output images
%   x_increment - x spacing between frequency slices
%   y_increment = y spacing between frequency slices
%   pupil - A function handle for the desired pupil. Rectangle by default.

if nargin < 6
    addpath('../pupils');
    pupil = @square_pupil;
    rmpath('./pupils');
end
addpath('../util');

% Create a logical mask for the pupil function
[X, Y] = scaled_meshgrid( low_y_res, low_x_res, 2, 2 );
pupil_mask = pupil(X, Y);

% Create the aperture plane
frequencies = fft_image( object );

% Sample the aperture plane
frequency_samples = sample_image(frequencies, low_x_res, low_y_res, x_increment, y_increment);
num_samples = size(frequency_samples, 3);

% Generate output images
images = [];
for i = 1:num_samples
    image = ifft_image( frequency_samples(:,:,i) .* pupil_mask );
    image = image .* conj(image);
    images = cat(3, images, image);
end
rmpath('../util');
end

