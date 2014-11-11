function [ object ] = create_test_image( amplitude_file, phase_file )
%CREATE_TEST_IMAGE Creates the largest square complex test image from two
%files
%   amplitude_file - filename of image to use for amplitude
%   phase_file - filename of image to use for phase

% Read in our files and convert them to grayscale doubles. We convert them
% to doubles, and normalize between 0 and 1 for the amplitude, and between
% -pi and pi for the phase.
amplitude = double(rgb2gray(imread(amplitude_file))) / 255;
phase = ((2 * double(rgb2gray(imread(phase_file))) / 255) - 1) * pi;

% Crop the images
dimension = min(  min(size(amplitude)), min(size(phase)) );
amplitude_cropped = amplitude(1:dimension, 1:dimension);
phase_cropped = phase(1:dimension, 1:dimension);

object = amplitude_cropped .* exp( 1i * phase_cropped );

end

