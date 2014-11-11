function mask = square_pupil( X, Y )
%SQUARE Creates a full pass-band of the 2 X 2 square centered at the origin
%   X and Y are meshgrid arrays
mask = ((abs(X) <= 1) & (abs(Y) <= 1));

end

