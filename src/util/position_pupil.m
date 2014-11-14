function mask = position_pupil( width, height, pupil, x, y )
%POSITION_PUPIL Create a full image mask with the pupil in the correct
%location.
%   width - The width, in pixels, of the full mask.
%   height - The height, in pixels, of the full mask,
%   x - The x-position, in pixels, of the pupil center
%   y - The y position, in pixels, of the pupil center

% Round the coordinates to the nearest actual pixels
x = round(x);
y = round(y);

% h and w are the dimensions of the pupil, not to be confused with height
% and width, the dimensions of the entire mask
[h, w] = size(pupil);

% Get the subsection of the full mask that we will be placing the pupil
% into.
left = floor(x - w/2) + 1;
right = floor(x + w/2);
top = floor(y - h/2) + 1;
bottom = floor(y + h/2);

% Crop the locations to the boundaries of the mask
left = max(1, left);
right = min(width, right);
top = max(1, top);
bottom = min(height, bottom);

% Crop the pupil itself if needed. Since (assuming the pupil is smaller
% than the mask) this should only happen when the pupil is too close to an
% edge, we need to check which edges we have hit, and subtract from that
% side of the pupil exclusively.

% These are the differences between the size of the pupil we have, and the
% bounds we created above.
dw = w - (right - left + 1);
dh = w - (bottom - top + 1);
if dw > 0
    if left == 1 % we are against the left edge of the image
        pupil = pupil( :, dw+1:w);
    else % we are against the right edge of the image
        pupil = pupil( :, 1:w-dw);
    end
end
if dh > 0
    if top == 1 % we are against the top edge of the image
        pupil = pupil(dh+1:h , : );
    else % we are against the bottom edge of the image
        pupil = pupil(1:h-dh , : );
    end
end

% Create the mask and place the pupil in it
mask = zeros([height, width]);
mask(top:bottom,left:right) = pupil;

end

