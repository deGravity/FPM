function pupil = extract_pupil( x, y, w, h, mask )
%EXTRACT_PUPIL Extracts a pupil of known position and radius from a mask.
%The inverse of position pupil.
%   x - x-coordinate of pupil
%   y - y-coordinate of pupil
%   w - the width of the pupil
%   h - the height of the pupil
%   mask - the mask that the pupil is embedded in

width = size(mask, 2);
height = size(mask, 1);

% TODO - Refactor to remove code-duplication in position_pupil - create a
% third function which determines the bounds of a pupil in another image.
% Should probably also re-name the functions to insert patch and extract
% patch at this time (since they are actually dealing with rectangular
% patches.

% Round the coordinates to the nearest actual pixels
x = round(x);
y = round(y);

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
padLeft = 0; padRight = 0; padTop = 0; padBottom = 0;
if dw > 0
    if left == 1 % we are against the left edge of the image
        padLeft = dw;
    else % we are against the right edge of the image
        padRight = dw;
    end
end
if dh > 0
    if top == 1 % we are against the top edge of the image
        padTop = dh;
    else % we are against the bottom edge of the image
        padBottom = dh;
    end
end

pupil = mask(top:bottom,left:right);

% We know that our pupil was restricted on the sides - pad by the needed
% amounts.
pupil = padarray(pupil, [padTop, padLeft], 0, 'pre');
pupil = padarray(pupil, [padBottom, padRight], 0, 'post');

end

