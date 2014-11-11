function [ image, transform, errors ] = run_basic_fpm( amplitude_file, phase_file )
%RUN_BASIC_FPM Entry point for basic_fpm given two image files
%   amplitude_file - path to file for amplitude of object
%   phase_file = path to file for phase of object

sampleResX = 50;
sampleResY = 50;
sampleDX = 10;
sampleDY = 10;
pupilFunction = @square_pupil;

addpath('../util');
addpath('../pupils');

object = create_test_image(amplitude_file, phase_file);

images = basic_fpm_simulation(object, sampleResX, sampleResY, sampleDX, sampleDY, pupilFunction);
[image, transform, errors] = basic_fpm_reconstruction(images, size(object,2), size(object, 1), sampleDX, sampleDY, pupilFunction, object);

end

