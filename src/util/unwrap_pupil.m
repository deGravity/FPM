function phase = unwrap_pupil( pupil, mask )
%UNWRAP_PUPIL Extract and unwrap the phase from a pupil function given a
%mask.
%   pupil - the complex-valued pupil
%   mask - a mask of the pupil to guide unwrapping.

phase = angle(pupil);
phase = unwrap(unwrap(phase)')';
phase = phase .* mask;
end