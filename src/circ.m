function [ mask ] = circ( x, y, r, m, n )
%CIRC Summary of this function goes here
%   Detailed explanation goes here

[X,Y] = meshgrid(linspace(-m/2, m/2, m)-x, linspace(-n/2, n/2, n)-y);
mask = X.^2 + Y.^2 <= r^2;

end

