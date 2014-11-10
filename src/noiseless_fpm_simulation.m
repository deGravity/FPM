function [ images, pupils ] = noiseless_fpm_simulation( amplitude_file, phase_file, scale )
%NOISELESS_FPM_SIMULATION A very basic fpm simulation. Simulates physically
%moving the pupil function in the Fourier domain
%   amplitude_file - an image to use as the amplitude
%   phase_file - an image to use as the phase
%   scale - scale factor of source to low res samples

source = create_test_image(amplitude_file, phase_file);
[full_rows, full_columns] = size(source);
high_res_transform = fft_image(source);
[Xgrid YGrid] = scaled_meshgrid(full_rows, full_columns, 2, 2);
% Iterate pupils - this should be made configurable
for x=linspace(-.5, .5, 10)
    for y=linspace(-.5,.5,10)
        pupil = circular_pupil(Xgrid, YGrid, x, y, .5);
        image = imresize(ifft_image(high_res_transform .* pupil), scale);
    end
end


end

