function maximum = mmax( M )
%MMAX Finds the largest value in a matrix of any size
%   Detailed explanation goes here

maximum = M;
for i=1:size(size(M),2)
    maximum = max(maximum);
end

end

