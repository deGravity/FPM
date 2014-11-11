function total_error = squared_error( im1, im2 )
%SQUARED_ERROR Calculates the l2 distance between two complex-valued images
%per degree of freedom (almost Chi-Square)
%   Simple sum of squared errors metric

diff = im1 - im2;
squared = diff .* conj(diff);
total_error = sum(sum(squared)) / (size(im1,1)*size(im1,2));

end

