function transform = zernike_transform( rows, columns, n )
%ZERNIKE_TRANSFORM Creates a transform function that returns the
%coefficients and projection onto the first n Zernike modes by Noll index
%   rows - The number of rows to be able to transform
%   columns - The number of columns to be able to transform
%   n - the number of modes to decompose into

[X,Y] = scaled_meshgrid(rows, columns, 2, 2 );
[R, THETA] = polar_meshgrid(X, Y);
mask = (R <= 1);
m = ssum(mask); % Number of points in the unit circle.
Z_func = zeros(rows, columns, n);
Z = zeros(m, n); % Will contain vectorized Zernike modes
for i=1:n
    Zi = zernike(i);
    Zi_func = Zi(R, THETA) .* mask;
    Z_func(:,:,i) = Zi_func;
    Z_col = Zi_func(mask == 1);
    Z(:,i) = Z_col;
end

Zinv = pinv(Z);

transform = @(F) doZernikeTransform( F, Zinv, Z_func, mask );

end

function [ coefficients, projection ] = doZernikeTransform( F, Zinv, Z_func, mask )
%DOZERNIKETRANSFORM Actually computes the transform

% TODO - Check if F has correct dimensions, resize if not.

P = F(mask == 1);
coefficients = Zinv * P;
projection = zeros(size(Z_func(:,:,1)));
for i = 1:size(coefficients)
    projection = projection + coefficients(i) * Z_func(:,:,i);
end

% TODO - Resize projection to original size if needed

end

