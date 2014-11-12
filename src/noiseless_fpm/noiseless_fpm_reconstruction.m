function [ image, transform ] = noiseless_fpm_reconstruction( images, pupils, iter_count )
%NOISELESS_FPM_RECONSTRUCTION Reconstruct the results of
%noiseless_fpm_simulation
%   images and pupils are the outputs of noiseless_fpm_simulation
addpath('../util');
width = size(images(:,:,1), 2);
height = size(images(:,:,1),1);

count = size(images,3);

image_phase = ones([height, width]);%random('Uniform', -pi, pi, height, width);
image_amplitude = sqrt(images(:,:,1));
image = image_amplitude .* image_phase;
transform = fft_image(image);
for j = 1:iter_count
    for i=1:count
        restricted_transform = pupils(:,:,i) .* transform;
        restricted_image = ifft_image(restricted_transform);
        restricted_image = sqrt(images(:,:,i)) .* exp( 1i * angle(restricted_image));
        renormalized_restricted_transform = fft_image(restricted_image);
        transform( pupils(:,:,i) == 1)  = renormalized_restricted_transform( pupils(:,:,i) == 1);
    end
end
image = ifft_image(transform);

end

