function [ images, pupil_base, pupil_corners ] = epry_simulation( object, overlap, num_x, num_y, aberrations )
%EPRY_SIMULATION Simulate fpm with aberations in the lens.
%   object - The complex image to sample
%   overlap - The percentage overlap between adjacent samples
%   num_x - The number of samples in the x direction
%   num_y - The number of samples in the y direction
%   aberrations - A vector of coefficients for Zernike polynomal
%   aberrations of the lens.


% The overlap of two circles of equal radius R that at separated by a
% distance d = kR, as a percentage of one circle's area is given by
%       L = (2 arccos(k/2) - (k/2) sqrt(4 - k^2)) / pi
% The first order Taylor expansion about k = 0, which is fairly accurate
% for 0 <= L <= 2, the regime that we care about, is
%       L ~= 1 - 2k/pi
% Therefore, for a given overlap L, we should have the spacing between
% pupils be equal to 
%       d = (1 - L)(pi/2) R.
%
% In order to have the circles span the width, W of the image, given that
% there will be n circles, we need that
%     W = 2R + (n - 1)d
%       = 2R + (n - 1)(1 - L)(pi/2) R
%       = R ( 2 + (n - 1)(1 - L)(pi/2) )
% Thus the radius of our pupils must be
%     R = W / ( 2 + (n - 1)(1 - L)(pi/2) )

[height, width] = size(object);
radius = width / ( 2 + (min(num_x, num_y) - 1) * (1 - overlap)*(pi/2) );

end

