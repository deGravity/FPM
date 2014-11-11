function visualize_pupil_overlap( pupils )
%VISUALIZE_PUPIL_OVERLAP Computes the overlap of a set of pupil functions
%as a heatmap and displays.
%   pupils - an collection of pupil functions
all_pupils = sum(pupils, 3);
figure;imagesc(all_pupils);
end

