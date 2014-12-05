function aberration = build_aberration( radius, coefficients )
%BUILD_ABERRATION Creates a sum of Zernike modes of a specified radius.
%   Detailed explanation goes here

[X, Y] = scaled_meshgrid(2*radius, 2*radius, 2, 2); 
[R, THETA] = polar_meshgrid(X, Y);
mask = (R <= 1);
aberration = zeros(size(mask));

for i=1:size(coefficients, 2)
    Z = zernike(i);
    aberration = aberration + coefficients(i) * Z(R, THETA);
end

aberration = aberration .* mask;

end

