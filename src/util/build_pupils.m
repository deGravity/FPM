function pupils = build_pupils( pupil_data, aberrations )
%BUILD_PUPILS Builds an array of pupil masks for an image.
%   pupil_data - The output of pupil_locations - a cell array containing
%       {image height, image width, pupil radius, x-centers, y-centers}
%   aberrations - (optional) The Zernike mode coefficients for any 
%       aberrations, indexed by Noll number starting at 1. If left empty, a
%       perfect circular mask will be created.

% Extract info from the pupil_data cell array
height = pupil_data{1};
width = pupil_data{2};
radius = pupil_data{3};
x_centers = pupil_data{4};
y_centers = pupil_data{5};

% Check to make sure that there are an equal number of x and y centers.
if size(x_centers) ~= size(y_centers)
    error('build_pupils:size', ...
        'The lengths of the coordinate center arrays must be equal.');
end

pupil = build_pupil(radius, aberrations);
pupils = [];
for y=y_centers
    for x=x_centers
        mask = position_pupil(width, height, pupil, x, y);
        pupils = cat(3, pupils, mask);
    end
end

end

