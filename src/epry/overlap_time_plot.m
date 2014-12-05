%overlap vs. convergence time

%define parameters
overlap_start=.1;
overlap_end=.9;
spaces=20;
%create overlap axis
overlap=linspace(overlap_start, overlap_end, spaces);

time=zeros(spaces, 4, 4);
for j=1:spaces
    for k=1:4
        for l=1:4
            amp=(['../images/128-' num2str(k) '.jpg']);
        
            pha=(['../images/128-' num2str(l) '.jpg']);
            params=epry_parameters(amp, pha);
            params.overlap_percentage=overlap(j);
            stats=epry_test(params);
            time(j, k, l)=stats.number_of_iterations;
        end
    end
end

