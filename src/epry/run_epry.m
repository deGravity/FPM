function [ reconstruction, pupil, object_error, pupil_error ] = run_epry( amplitude_file, phase_file )
%RUN_EPRY Run simulation and reconstruction for given amplitude and phase
%images.
%   amplitude_file - path to image for amplitude signal
%   phase_file - path to image for phase signal

addpath('../util');

% The parameters
overlap = .8;
num_x = 15;
num_y = 15;
aberrations = [];
iterations = 10;

object = create_test_image_unit_norms(amplitude_file, phase_file);
[images, pupil_data] = epry_simulation(object, overlap, num_x, num_y, aberrations);
[reconstruction, pupil, object_error, pupil_error] = epry_reconstruction(images, pupil_data, iterations, object); 


end

