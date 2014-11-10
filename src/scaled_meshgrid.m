function [ X Y ] = scaled_meshgrid( rows, columns, height, width, xshift, yshift )
%SCALED_MESHGRID Creates a meshgrid that is scaled to a real coordinate
%system, with an optional shift of origin. By default, the origin is in the
%center of the grid.
%   rows - the number of rows in the output matrix
%   columns - the number of columns in the output matrix
%   height - the height of the coordinate system in real coordinates
%   width - the width of the coordinate system in real coordinates
%   xshift - the center of the coordinate system, in real coordinates
%   yshift - the center of the coordinate system, in real coordinates

if nargin < 5
    xshift = 0;
end

if nargin < 6
    yshift = 0;
end

x = linspace( -width / 2 + xshift, width / 2 + xshift, columns);
y = linspace(height / 2 + yshift, -height / 2 + yshift, rows );
[X Y] = meshgrid(x,y);

end

