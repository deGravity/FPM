function [object, pupil, object_errors, pupil_errors] = epry_reconstruction( images, pupil_data, num_iterations, doEPRY, alpha, beta,  projection_modes, reference_object, reference_aberrations )
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
doObjectError = true;
doPupilError = true;
object_errors = zeros(1,num_iterations);
pupil_errors = zeros(1,num_iterations);

if nargin < 4
    doEPRY = false;
    alpha = 1;
    beta = 1;
end
if nargin < 7
    projection_modes = 0;
    doObjectError = false;
    doPupilError = false;
end
if nargin < 8
    doObjectError = false;
end
if nargin < 9
    doPupilError = false;
end
if doObjectError
    reference_frequency = fft_image(reference_object);
end
if doPupilError
    reference_pupil = build_pupil(pupil_data{3}, reference_aberrations);
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
pupil = double(build_pupil(pupil_data{3}));

% Keep a perfect pupil for masking
perfect_pupil = build_pupil(pupil_data{3});
[pupil_height, pupil_width] = size(perfect_pupil);

% Initial Frequency Domain image
frequency = fft_image(object);

if projection_modes > 0
    transform = zernike_transform(pupil_height, pupil_width, projection_modes);
end

% Iterate the EPRY loop several times over all images
for i=1:num_iterations
    for j=1:size(images,3)
        [x, y] = get_pupil_location(j, x_centers, y_centers);
        pupil_mask = position_pupil(width, height, pupil, x, y);
        perfect_pupil_mask = position_pupil(width, height, perfect_pupil, x, y);
        
        restricted_frequency = pupil_mask .* frequency;
        restricted_image = ifft_image(restricted_frequency);
        restricted_image = sqrt(images(:,:,j)) .* exp( 1i * angle(restricted_image) );
        updated_restricted_frequency = fft_image(restricted_image);
        frequency_delta = updated_restricted_frequency - restricted_frequency;
        
        frequency_update = conj(pupil_mask) .* ( frequency_delta );
        frequency_update = alpha * frequency_update / mmax( abs(pupil) )^2;
        
        if doEPRY
            pupil_update = conj(frequency) .* ( frequency_delta );
            pupil_update = beta * pupil_update / mmax( abs(frequency(perfect_pupil_mask == 1)) )^2;
        end
        
        frequency(perfect_pupil_mask == 1) = frequency(perfect_pupil_mask == 1) + frequency_update(perfect_pupil_mask == 1);
        if doEPRY
            pupil(perfect_pupil == 1) = pupil(perfect_pupil == 1) + pupil_update( perfect_pupil_mask == 1);
            if projection_modes > 0
                phase = angle(pupil);
                [~, phase] = transform(phase); % Project onto the first several Zernike modes
                pupil = perfect_pupil .* exp( 1i * phase);
            end
        end
    end

    if doObjectError
        % EPRY Statistics
        a = ssum(reference_frequency .* conj(frequency)) / ssum( abs(frequency).^2 );
        esquared = ssum( abs(reference_frequency - a * frequency) .^2 ) / ssum( abs(reference_frequency).^2 );
        object_errors(i) = esquared;
    end
    if doPupilError
        error = squared_error(angle(reference_pupil), angle(pupil));
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

