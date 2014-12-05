classdef epry_parameters
    %EPRY_PARAMETERS Parameters and defaults for EPRY simulation.
    properties
        amp;
        phase;
        overlap_percentage = .75;
        num_x = 10;
        num_y = 10;
        aberrations = [0, .8, .7, .6, .5, .4, .3, .2];
        projection_modes = 8;
        max_iterations = 20;
        threshold = 0.1;
        alpha = 1;
        beta = 1;
    end
    
    properties (Dependent)
        object;
    end
    
    properties (Hidden)
        hidden_object = [];
    end
    
    methods
        function params = epry_parameters(amplitude_image, phase_image)
            params.amp = amplitude_image;
            params.phase = phase_image;
        end
        function value = get.object(obj)
            if size(obj.hidden_object) == 0
                addpath('../util');
                obj.hidden_object = create_test_image_unit_norms(obj.amp, obj.phase);
            end
            value = obj.hidden_object;
        end
    end
end