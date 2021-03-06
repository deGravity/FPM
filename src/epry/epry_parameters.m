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
    
    properties (Dependent)
        aberration_energy;
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
        
        function value = get.aberration_energy(obj)
            addpath('../util');
            value = norm_disk_l2(build_aberration(20,obj.aberrations));
        end
        
        function obj = set.aberration_energy(obj, value)
            addpath('../util');
            energy = norm_disk_l2(build_aberration(20,obj.aberrations));
            multiplier = value / energy;
            obj.aberrations = obj.aberrations * multiplier;
        end
    end
end