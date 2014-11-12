function [ image, frequency, errors ] = basic_fpm_reconstruction( images, x_res, y_res, x_increment, y_increment, pupil, object )
%BASIC_FPM_RECONSTRUCTION Summary of this function goes here
%   Detailed explanation goes here
addpath('../util');
if nargin < 6
    addpath('../pupils');
    pupil = @square_pupil;
    rmpath('../pupils');
end

% If an object reference is provided, use it to calculate errors
if nargin > 6
    reference = fft_image(object);
end

image_amplitude = imresize(images(:,:,1), [y_res, x_res]);
image_phase = exp( 1i * random('Uniform', -pi, pi, y_res, x_res));
image = image_amplitude .* image_phase;
frequency = fft_image(image);

low_x_res = size(images(:,:,1), 2);
low_y_res = size(images(:,:,1), 1);

% Create a logical mask for the pupil function
[X, Y] = scaled_meshgrid( low_y_res, low_x_res, 2, 2 );
pupil_mask = pupil(X, Y);

% Generate the locations of the frequency domain samples
edges = generate_sample_edges(x_res, y_res, low_x_res, low_y_res, x_increment, y_increment);
num_images = size(edges, 2);
num_loops = 10;
errors = zeros(num_images*num_loops,1);
for j = 1:num_loops
for i = 1:num_images
    frequency_sample = frequency(edges(1,i):edges(2,i),edges(3,i):edges(4,i));
    frequency_sample = frequency_sample .* pupil_mask;
    spacial_sample = ifft_image(frequency_sample);
    spacial_sample = sqrt(images(:,:,i)) .* exp( 1i * angle(spacial_sample) );
    frequency_sample_corrected = fft_image(spacial_sample);
    frequency_sample( pupil_mask == 1) = frequency_sample_corrected( pupil_mask == 1);
    frequency(edges(1,i):edges(2,i),edges(3,i):edges(4,i)) = frequency_sample;
    % If we have a reference, calculated errors
    if (nargin > 6)
        error = squared_error(reference, frequency);
        errors(i + num_images*(j-1)) = error;
    end
end
end
image = ifft_image(frequency);
rmpath('../util');
end

