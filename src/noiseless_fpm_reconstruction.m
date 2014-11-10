function [ high_res_image, high_res_transform ] = noiseless_fpm_reconstruction( images, pupils )
%NOISELESS_FPM_RECONSTRUCTION Reconstruct the results of
%noiseless_fpm_simulation
%   images and pupils are the outputs of noiseless_fpm_simulation

low_res_width = size(images(:,:,1), 2);
low_res_height = size(images(:,:,1),1);
high_res_width = size(pupils(:,:,1),2);
high_res_height = size(pupils(:,:,1),1);

count = size(images,3);

high_res_image_phase = random('Uniform', -pi, pi, high_res_height, high_res_width);
high_res_image_amplitude = imresize(abs(images(:,:,1)), [high_res_height, high_res_width]);
high_res_image = complex( high_res_image_amplitude, high_res_image_phase );
high_res_transform = fft_image(high_res_image);
    for i=1:count
        restricted_transform = pupils(:,:,i) .* high_res_transform;
        restricted_high_res_image = ifft_image(restricted_transform);
        restricted_low_res_image = imresize(restricted_high_res_image, [low_res_height, low_res_width]);
        low_res_image = abs(images(:,:,i)) .* angle(restricted_low_res_image);
        high_res_restricted_image = imresize(low_res_image, [high_res_height, high_res_width]);
        renormalized_restricted_transform = fft_image(high_res_restricted_image) .* pupils(:,:,i);
        high_res_transform = high_res_transform .* (1 - pupils(:,:,i)) + renormalized_restricted_transform;
    end
high_res_image = ifft_image(high_res_transform);

end

