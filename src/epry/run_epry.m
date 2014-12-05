function [ reconstruction, pupil, original_image, original_pupil, object_error, pupil_error ] = run_epry( amplitude_file, phase_file, pscale )
%RUN_EPRY Run simulation and reconstruction for given amplitude and phase
%images.
%   amplitude_file - path to image for amplitude signal
%   phase_file - path to image for phase signal

addpath('../util');

% The parameters
overlap = .75;
num_x = 10;
num_y = 10;
aberrations = pscale * [0, .8, .7, .6, .5, .4, .3, .2];
iterations = 16;
threshold = .1;
alpha = 1;
beta = 1;

object = create_test_image_unit_norms(amplitude_file, phase_file);

[images, pupil_data] = epry_simulation(object, overlap, num_x, num_y, aberrations);
[reconstruction, pupil, object_error, pupil_error, ~] = epry_reconstruction(images, pupil_data, iterations, threshold, true, alpha, beta, size(aberrations,2), object, aberrations); 
original_image = object;
original_pupil = build_pupil(pupil_data{3}, aberrations);
end

