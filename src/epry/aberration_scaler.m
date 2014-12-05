% Run EPRY repeatedly with scaled aberrations

%define parameters 
scaler=.1; %percentage increase per iteration
itermax= 10; %number of iterations
ampfile= '../images/flour.jpg'; %amplitude file
phafile= '../images/flower.jpg'; %phase file
recon_old = [];
pupil_old = [];
for j=0:itermax
     pscale=1+j*scaler;
     [recon, pupil, oi, op, oe, pe]=run_epry(ampfile, phafile, pscale);
     
     figure
     title(['Pupil Scale' num2str(1+j*scaler)])
     colormap gray
     
     subplot (2,5,1)
     imagesc(abs(op))
     title('Input Pupil Amplitude')
     
     subplot(2,5,2)
     imagesc(angle(op))
     title('Input Pupil Phase')
     
     subplot(2,5,3)
     imagesc(abs(pupil))
     title('Reconstructed Pupil Amplitude')
     
     subplot(2,5,4)
     imagesc(angle(pupil))
     title('Reconstruction Pupil Phase')
     
     subplot(2,5,5)
     imagesc(abs(recon))
     title('Amplitude Reconstruction')
     
     subplot(2,5,6)
     imagesc(angle(recon))
     title('Phase Reconstruction')
     
     subplot(2,5,7)
     plot(oe)
     title('EPRY Error')
     
     
     subplot(2,5,8)
     plot(pe)
     title('Pupil Mean Squared Error')
     
     if size(pupil_old, 1) > 0
         recon_diff = recon - recon_old;
         pupil_diff = angle(pupil) - angle(pupil_old);
         subplot(2,5,9)
         imagesc(abs(recon_diff));
         title('Reconstruction Diff');
         subplot(2,5,10)
         imagesc(pupil_diff);
         title('Pupil Diff');
     end
     recon_old = recon;
     pupil_old = pupil;
end 