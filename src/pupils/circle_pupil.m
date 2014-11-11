function mask = circle_pupil( X, Y )
%CIRCLE Creates a unit circle mask
%   X Y are assumed to be a meshgrid of [-1,1] X [-1, 1]
mask = X.^2 + Y.^2 <= 1;
end

