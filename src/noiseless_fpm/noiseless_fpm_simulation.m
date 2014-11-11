function [ images, pupils ] = noiseless_fpm_simulation( amplitude_file, phase_file, min_kx, max_kx, num_kx, min_ky, max_ky, num_ky, k_radius )
%NOISELESS_FPM_SIMULATION A very basic fpm simulation. Simulates physically
%moving the pupil function in the Fourier domain
%   amplitude_file - an image to use as the amplitude
%   phase_file - an image to use as the phase

addpath('../pupils');
addpath('../util');

% Default values if not all pupil arguments are given
if nargin < 9
    min_kx = -.5;
    max_kx = .5;
    num_kx = 10;
    min_ky = -.5;
    max_ky = .5;
    num_ky = 10;
    k_radius = .5;
end

source = create_test_image(amplitude_file, phase_file);
[full_rows, full_columns] = size(source);
high_res_transform = fft_image(source);
[Xgrid, YGrid] = scaled_meshgrid(full_rows, full_columns, 2, 2);

% Initialize Output Arrays
images = [];
pupils = [];

% Iterate pupils - this should be made configurable
for x=linspace(min_kx, max_kx, num_kx)
    for y=linspace(min_ky,max_ky,num_ky)
        pupil = circular_pupil(Xgrid, YGrid, x, y, k_radius);
        image = ifft_image(high_res_transform .* pupil);
        
        % Push the new pupil and image functions onto the output arrays
        images = cat(3, images, image);
        pupils = cat(3, pupils, pupil);
    end
end


end

