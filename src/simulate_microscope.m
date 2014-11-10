function [ image ] = simulate_microscope( object, aperture )
%SIMULATE_MICROSCOPE Simulate the effects of a simple microscope system.
%For this simple situation, the aperature matrix is assumed to implicitly
%contain the effects of varied illumination
%   object - a complex matrix representing the sample's transmittance
%   aperture - a complex matrix representing the lens aberitions

image = abs(ifft(fft(object) .* aperture));

end

