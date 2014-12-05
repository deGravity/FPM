function norm = norm_disk_l2( f )
%NORM_DISK_L2 Calculate the L2 norm of a function defined on the unit disk
%   f - A sampled function to calculate the norm of.

radius = size(f,1)/2;
norm = sqrt( ssum(abs(f).^2)/ (pi * radius^2) );

end

