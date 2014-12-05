
%define parameters
overlap_start=.50;
overlap_end=.95;
spaces=10;
pscale=.75;

image_sizes=[128, 256, 512, 1024];

%create overlap axis
overlap=linspace(overlap_start, overlap_end, spaces);

%load images
epry = zeros(spaces, 2*size(image_sizes,2));
for j=1:spaces
    for k=1:size(image_sizes, 2)
        for l=1:2
        amp=([num2str(image_sizes(k)) '-' num2str((2*l)-1) '.jpg']);
        
        pha=([num2str(image_sizes(k)) '-' num2str(2*l) '.jpg']);
        
        [recon, pupil, oi, op, oe, pe]=run_epry(amp, pha, pscale, overlap(j));
        
        epry(j,k,l) = oe(size(oe,2)) ;
        end
    end
end
epry = sum(epry,3) / size(epry,3);
epry =  sum(epry, 2) / size( epry, 2);
plot(epry)

            