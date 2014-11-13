function Z = zernike( m, n )
%ZERNIKE creates a Zernike polynomial as a function of r and theta. There
%are two ways to call this function:
%   zernike(m,n)
%       m - the frequency number of the polynomial
%       n - the mode number of the polynomial
%       Must have n >= |m| >= 0.
%   zernike(j)
%       j - the Noll index of the desired Zernike polynomial

% If we only got one argument, we are indexing by Noll index, so set m and
% n accordingly.
if nargin == 1
    j = m;
    [m, n] = noll_index(j);
end

% Check that the mode and frequency are valid.
if ( n < 0 || abs(m) > n )
    error('zernike:mnvals', 'Must have n >= |m| >= 0.');
end
R = radial_zernike(abs(m), n);
if ( m >= 0 )
    % Even Zernike Polynomial
    Z = @(r, theta) R(r) * cos( m * theta );
else
    % Odd Zernike Polynomial
    Z =  @(r, theta) R(r) * sin( abs(m) * theta );
end

end

function R = radial_zernike(m, n)
%RADIAL_ZERNIKE - creates the radial polynomial part of the mth frequency,
%nth order Zernike polynomial

    % Create coefficients in a loop because conditionals and binomials
    % do not vectorize well.
    coeffs = n:-1:0;
    for i=1:n+1
        coeffs(i) = zernike_coefficient(m, n, i);
    end

    R = @(r) polyval( coeffs, r );
end

function c = zernike_coefficient(m, n, p)
    % Binomial form of the Zernike coefficients from 
    %   http://en.wikipedia.org/wiki/Zernike_polynomials
    % translated into the powers of "r" rather than summation form.
    coeff = @(m, n, p) (-1).^( (n - p)/2 ) .* ...
        nchoosek( (n+p)/2, (n-p)/2 ) .* ...
        nchoosek( p, (p - m) / 2);    
    if ( mod(m-n,2) == 0 && p >= m && mod(p,2) == mod(n,2) )
        c = coeff(m, n, p);
    else
        c = 0;
    end
end

function [m, n] = noll_index(j)
%NOLL_INDEX - compute the j'th noll index into the zernike polynomials

% There are n+1 noll indices per Zernike mode, so iterate to figure out
% which mode we are in.
n = 1;
sum = 0;
while (sum < j)
    sum = sum + n;
    n = n + 1;
end
n = n - 2;

% This is how many m's into a particular mode we are. Calculated by
% counting the number of Noll indices in the lower modes and subtracting
% from the index we want.
freq_num = j - (n*(n+1)/2);
m = 0;
% Counting changes based on parity of j and n

% Even modes start with 0 m.
if ( mod(n, 2) == 0 )
    freq_num = freq_num - 1;
    m = 2 * ceil(freq_num / 2)
else
    m = 2 * ceil( (freq_num ) / 2) - 1;
end

% Sign of m is determined by parity of j
if ( mod(j,2) == 1 )
    m = -m;
end

end