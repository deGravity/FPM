classdef epry_statistics
   properties
       original_image;
       reconstructed_image;
       original_pupil;
       original_pupil_coefficients;
       reconstructed_pupil;
       reconstructed_pupil_coefficients;
       epry_statistic_series;
       final_epry_statistic;
       pupil_error_series;
       final_pupil_error;
       number_of_iterations;
       maxed_iterations = false;
   end
   
   methods
       function stats = epry_statistics()
       end
       function plot(obj)
           subplot(3,3,1);
           imagesc(abs(obj.original_image));
           title('Original Image Modulus');
           
           subplot(3,3,2);
           imagesc(angle(obj.original_image));
           title('Original Image Phase');
           
           subplot(3,3,3);
           imagesc(angle(obj.original_pupil));
           title('Original Pupil Phase');
           
           subplot(3,3,4);
           imagesc(abs(obj.reconstructed_image));
           title('Reconstructed Image Modulus');
           
           subplot(3,3,5);
           imagesc(angle(obj.reconstructed_image));
           title('Reconstructed Image Phase');
           
           subplot(3,3,6);
           imagesc(angle(obj.reconstructed_pupil));
           title('Reconstructed Pupil Phase');
           
           subplot(3,3,7);
           plot(obj.epry_statistic_series);
           title('EPRY Statistic');
           
           subplot(3,3,8);
           plot(obj.pupil_error_series);
           title('Pupil MSE per DOF');
           
           subplot(3,3,9);
           original_indices = 1:size(obj.original_pupil_coefficients,2);
           recon_indices = 1:size(obj.reconstructed_pupil_coefficients, 2);
           plot(original_indices, obj.original_pupil_coefficients,'r*', ...
           recon_indices, obj.reconstructed_pupil_coefficients, 'go');
           title('Aberration Zernike Modes');
           
       end
   end
end
