function [object, pupil, object_errors, pupil_errors] = epry_reconstruction( images, pupil_data, num_iterations, reference_object, reference_aberrations )
%EPRY_RECONSTRUCTION Reconstruct an FPM image with EPRY pupil recovery.
%   images - The set of sampled images, ordered the same as the pupils in
%       pupil-data
%   pupil_data - The output of pupil_locations used to simulate the images
%   num_iterations - The number of iterations to perform
%   reference_object - (optional) - The original imaged object to test
%       object convergence against.
%   reference_pupil - (optional) = The actual aberration coefficients to
%       test pupil convergence against.

addpath('../util');

% Initialize the error tracking as empty arrays. If references are given,
% do error checking
doObjectError = false;
doPupilError = false;
object_errors = zeros(1,num_iterations);
pupil_errors = zeros(1,num_iterations);
if nargin > 3
    doObjectError = true;
end
if nargin > 4
    doPupilError = true;
    reference_pupil = make_pupil(pupil_data{3}, referenceAberrations);
end

% Choose an index of a pupil near the center of the plane. We are relying
% on knowing that build_pupils iterates horizontally first.
% Get the length of the lists of pupil x and y coordinates.
x_centers = pupil_data{4};
y_centers = pupil_data{5};
num_x = size(x_centers,2);
num_y = size(y_centers,2);
middle_index = round( (num_y/2)*num_x + num_x / 2 );

% Build an initial object guess
object = sqrt(images(:,:,middle_index));
phase = exp( 1i * ones(size(object)) ); % TODO - Try random phase guess
object = object .* phase;

width = size(object,2);
height = size(object, 1);

% Build an initial pupil guess
pupil = build_pupil(pupil_data{3});

% Keep a perfect pupil for masking
perfect_pupil = build_pupil(pupil_data{3});

% Initial Frequency Domain image
frequency = fft_image(object);

% Iterate the EPRY loop several times over all images
for i=1:num_iterations
    for j=1:size(images,3)
        [x, y] = get_pupil_location(j, x_centers, y_centers);
        pupil_mask = position_pupil(width, height, pupil, x, y);
        perfect_pupil_mask = position_pupil(width, height, perfect_pupil, x, y);
        
        filtered_frequency = pupil_mask .* frequency;
        filtered_spacial = ifft_image(filtered_frequency);
        filtered_spacial = sqrt(images(:,:,j)) .* exp( 1i * angle(filtered_spacial));
        filtered_frequency = fft_image(filtered_spacial);
        frequency( perfect_pupil_mask == 1) = filtered_frequency( perfect_pupil_mask == 1);
         
    end
    if doObjectError
        object = ifft_image(frequency);
        error = squared_error(reference_object, object);
        object_errors(i) = error;
    end
    if doPupilError
        error = squared_error(reference_pupil, pupil);
        pupil_errors(i) = error;
    end
end

object = ifft_image(frequency);

end

function [x, y] = get_pupil_location( index, x_centers, y_centers )
%GET_PUPIL_LOCATION Gets the center of a pupil from a list of x and y
%centers as indexed by position_pupil.
num_x = size(x_centers,2);
y_index = ceil(index / num_x);
x_index = index - ((y_index - 1) * num_x);
x = x_centers(x_index);
y = y_centers(y_index);
end

