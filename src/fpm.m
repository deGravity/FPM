function [ image ] = fpm( apertures, observations )
% Main entry point for FPM reconstruction
%   Given a set of known aperture functions and observed intensities,
%   reconstructs a high resolution complex image

% TODO:
% - Make sure that the number of apertures / observations match
% - Make sure that the dimensions of the arrays match

m = size(observations(:,:,1),1);
n = size(observations(:,:,1),2);
count = size(observations,3);

image_phase = random('Uniform', -pi, pi, m, n);
image_amplitude = observations(:,:,1);
image = complex( image_amplitude, image_phase );
frequency = fft_2d(image);
    for i=1:count
        restricted_frequency = apertures(:,:,i) .* frequency;
        restricted_image = ifft_2d(restricted_frequency);
        normalized_restricted_image = restricted_image .* abs( observations(:,:,i) ./ restricted_image );
        normalized_restricted_frequency = fft_2d(normalized_restricted_image);
        frequency = frequency - restricted_frequency + normalized_restricted_frequency;
    end
image = ifft_2d(frequency);

end

