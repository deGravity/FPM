function pupil = build_pupil( radius, aberrations )
%PUPIL Builds a pupil mask of width 2*radius with given aberrations.
%   radius - Radius (in pixels) of the pupil aperture
%   aberrations - Array of Zernike mode coefficients indexed by Noll index.
%       Ommit or use an empty array to produce a perfect pupil.

% Create a polar-coordinate mesh grid
[X, Y] = scaled_meshgrid(2*radius, 2*radius, 2, 2); 
[R, THETA] = polar_meshgrid(X, Y);
pupil = (R <= 1);

% If we have aberration coefficients, add them into the phase of the filter
if (nargin > 1) && (size(aberrations, 2) > 0)
    pupil = complex(double(pupil));
    for i=1:size(aberrations, 2)
        Z = zernike(i);
        pupil = pupil .* exp( 1i * aberrations(i) * Z(R, THETA) );
    end
end

end

