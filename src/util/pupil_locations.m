function [ pupil_data ] = pupil_locations( width, height, overlap, num_x, num_y )
%PUPIL_LOCATIONS Calculates the required size and placement of pupils to
%achieve a desired number of pupils and overlap percentage.
%   width - The width, in pixels, of the image to be tiled.
%   height - The height, in pixels, of the image to be tiled.
%   overlap - The percentage overlap between adjacent pupils
%   num_x - The number of pupils to tile with in the x (width) direction
%   num_y - The number of pupils to tile with in the y (height) direction

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

radius = width / ( 2 + (min(num_x, num_y) - 1) * (1 - overlap)*(pi/2) );

% The separation in either direction is then w = 2R + (n - 1) dx
dx = (width - 2*radius) / (num_x - 1);
dy = (height - 2*radius) / (num_y - 1);

% Therefore, the centers will be
pupil_x_centers = radius + (0:(num_x - 1)) * dx;
pupil_y_centers = radius + (0:(num_y - 1)) * dy;

pupil_data = {height, width, radius, pupil_x_centers, pupil_y_centers};

end

