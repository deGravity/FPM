function phase = unwrap_pupil( pupil, mask )
%UNWRAP_PUPIL Extract and unwrap the phase from a pupil function given a
%mask.
%   pupil - the complex-valued pupil
%   mask - a mask of the pupil to guide unwrapping.

phase = angle(pupil);
%for i = 1:size(pupil,2)
%    for j = round(size(pupil,1)/2):-1:1
%        if ( mask(j,i) == 0 )
%            phase(j,i) = phase(j+1, i);
%        end
%    end
%    for j = round(size(pupil,1)/2):1:size(pupil,1)
%        if (mask(j,i) == 0)
%            phase(j,i) = phase(j-1, i);
%        end
%    end
%end
phase = unwrap(unwrap(phase)')';
phase = phase .* mask;
end

