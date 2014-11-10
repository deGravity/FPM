function [ amplitude, phase ] = separate_complex_image( image )
%SEPARATE_COMPLEX_IMAGE Separates a complex image into its renormalized
%amplitude and phase
%   image - a complex matrix to be separated. It is assumed that the
%   phases are normalized between -pi and pi

amplitude = abs(image);
phase = ( angle(image) / pi + 1) / 2;

end

