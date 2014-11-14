function [ R, THETA ] = polar_meshgrid( X, Y )
%POLAR_MESHGRID Create a polar meshgrid from a normal meshgrid
%   X, Y are the output of a usual or scaled meshgrid.
R = sqrt( X.^2 + Y.^2 );
THETA = atan2( Y, X );

end

