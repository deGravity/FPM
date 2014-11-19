function summation = ssum( M )
%MMAX Finds the largest value in a matrix of any size
%   Detailed explanation goes here

summation = M;
for i=1:size(size(M),2)
    summation = sum(summation);
end

end

