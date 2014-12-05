%plot aberration scale vs mean last epry statistic 

%define parameters
overlap=0.75;
pscale_start=1.0;
pscale_end=5.5;
spaces=10;


image_sizes=[128, 256, 512, 1024];

%create overlap axis
pscale=linspace(pscale_start, pscale_end, spaces);

%load images
epry = zeros(spaces, 2*size(image_sizes,2));
for j=1:spaces
    for k=1:1 %size(image_sizes, 2)
        for l=1:4
            for m=1:4
                amp=(['../images/' num2str(image_sizes(k)) '-' num2str(l) '.jpg']);
        
                pha=(['../images/' num2str(image_sizes(k)) '-' num2str(m) '.jpg']);
        
                [recon, pupil, oi, op, oe, pe]=run_epry(amp, pha, pscale(j), overlap);
        
                epry(j,k,l) = oe(size(oe,2)) ;
            end
        end
    end
end
epry=squeeze(epry(:,1,:))
epry=sum(epry, 2)/size(epry, 2)
plot(pscale, epry)
xlabel('Aberration Scale')
ylabel('Final EPRY Error')

            