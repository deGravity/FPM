function [images, filenames] = load_tilt_series(directory)
%LOAD_TILT_SERIES reads all of the files in a directory
%   Detailed explanation goes here
addpath('../ReadDMFile');
listing = dir(directory);
images = [];
filenames = [];
for i = 3:size(listing,1)
    filenames = cat(1, filenames, listing(i).name);
    [image, ~, ~] = ReadDMFile(strcat(directory, '/', listing(i).name));
    images = cat(3, images, image);    
end
end

