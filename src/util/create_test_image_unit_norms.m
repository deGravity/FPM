function object = create_test_image_unit_norms( amplitude_file, phase_file )
%CREATE_TEST_IMAGE_NO_NORMALIZATION Creates the largest square complex test
%image from two files
%   amplitude_file - filename of image to use for amplitude
%   phase_file - filename of image to use for phase

% Read in our files and convert them to grayscale doubles. 
if ndims(imread(amplitude_file))>2
    amplitude = double(rgb2gray(imread(amplitude_file)));
else
    amplitude=double(imread(amplitude_file));
end
amplitude = amplitude / (max(max(amplitude)));

if ndims(imread(phase_file))>2
    phase = double(rgb2gray(imread(phase_file)));
else
    phase=double(imread(phase_file));
end   
phase = phase / max(max(phase));

% Crop the images
dimension = min(  min(size(amplitude)), min(size(phase)) );
amplitude_cropped = amplitude(1:dimension, 1:dimension);
phase_cropped = phase(1:dimension, 1:dimension);

object = amplitude_cropped .* exp( 1i * phase_cropped );

end