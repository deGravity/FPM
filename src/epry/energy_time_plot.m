%overlap vs. convergence time

%define parameters
energy_start=.1;
energy_end=.9;
spaces=10;
%create overlap axis
energy=linspace(energy_start, energy_end, spaces);

time=zeros(spaces, 4, 4);
for j=1:spaces
    for k=1:4
        for l=1:4
            amp=(['../images/128-' num2str(k) '.jpg']);
        
            pha=(['../images/128-' num2str(l) '.jpg']);
            params=epry_parameters(amp, pha);
            params.aberration_energy=energy(j);
            stats=epry_test(params);
            time(j, k, l)=stats.number_of_iterations;
        end
    end
end

t=sum(time, 3)/4;
s=sum(t,2)/4;
plot(energy, s);
xlabel('Aberration "Energy"');
ylabel('Time to Convergence');