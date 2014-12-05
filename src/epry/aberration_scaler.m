% Run EPRY repeatedly with scaled aberrations

%define parameters 
scaler=.3; %percentage increase per iteration
itermax= 10; %number of iterations
ampfile= 'beyonce.png'; %amplitude file
phafile= 'cameraman.jpg'; %phase file

for j=0:itermax
     pscale=1+j*scaler;
     [recon, pupil, oi, op, oe, pe]=run_epry(ampfile, phafile, pscale);
     
     figure
     title(['Pupil Scale' num2str(1+j*scaler)])
     colormap gray
     
     subplot (2,4,1)
     imagesc(abs(op))
     title('Input Pupil Amplitude')
     
     subplot(2,4,2)
     imagesc(angle(op))
     title('Input Pupil Phase')
     
     subplot(2,4,3)
     imagesc(abs(pupil))
     title('Reconstructed Pupil Amplitude')
     
     subplot(2,4,4)
     imagesc(angle(pupil))
     title('Reconstruction Pupil Phase')
     
     subplot(2,4,5)
     imagesc(abs(recon))
     title('Amplitude Reconstruction')
     
     subplot(2,4,6)
     imagesc(angle(recon))
     title('Phase Reconstruction')
     
     subplot(2,4,7)
     plot(oe)
     title('Object Mean Squared Error')
     
     
     subplot(2,4,8)
     plot(pe)
     title('Pupil Mean Squared Error')      
end 