function samples = sample_image( image, sample_width, sample_height, x_increment, y_increment )
%SAMPLE_IMAGE Samples an image with rectangles of given size and spacing.
%Does not attempt to compensate for non-even divisions, but will instead
%not sample the right and bottom edges of the image if the next sample
%would have gone outside the image boundaries.
%   image - the image to be sampled
%   sample_width - the width of each sample to take
%   sample_height - the height of each sample to take
%   x_increment - difference between each sample in the x direction
%   y_increment - difference between each sample in the y direction

height = size(image, 1);
width = size(image, 2);

edges = generate_sample_edges(height, width, sample_width, sample_height, x_increment, y_increment);
num_samples = size(edges, 2);
samples = [];
for i = 1:num_samples
    sample = image(edges(1,i):edges(2,i),edges(3,i):edges(4,i));
    samples = cat(3, samples, sample);
end
end

