function statistics = epry_test( parameters )
%EPRY_TEST Run a simulated test of the EPRY algorithm.
%   parameters - An epry_parameters object containing the desired settings.
%   returns an epry_statistics object with the results of the test.

[images, pupil_data] = epry_simulation(parameters.object, ...
    parameters.overlap_percentage, ...
    parameters.num_x, parameters.num_y, parameters.aberrations);

[reconstruction, pupil, object_error, pupil_error, zernike_modes] = ... 
    epry_reconstruction(images, pupil_data, parameters.max_iterations, ...
    parameters.threshold, true, parameters.alpha, parameters.beta, ...
    parameters.projection_modes, parameters.object, ... 
    parameters.aberrations);

statistics = epry_statistics();
statistics.original_image = parameters.object;
statistics.reconstructed_image = reconstruction;
statistics.original_pupil = build_pupil(pupil_data{3}, ... 
    parameters.aberrations);
statistics.original_pupil_coefficients = parameters.aberrations;
statistics.reconstructed_pupil = pupil;
statistics.reconstructed_pupil_coefficients = zernike_modes';
statistics.epry_statistic_series = object_error;
statistics.final_epry_statistic = object_error(end);
statistics.pupil_error_series = pupil_error;
statistics.final_pupil_error = pupil_error(end);
statistics.number_of_iterations = size(object_error, 2);
statistics.maxed_iterations = ...
    (statistics.number_of_iterations == parameters.max_iterations);
end

