fx = imread('woman.jpeg');
gx = imread('boathouse.jpeg');

%Create the binary images
fxbin = im2bw(fx);
gxbin = im2bw(gx);

%Get the DFT
fxFFT = fft2(fx);
gxFFT = fft2(gx);

%Center the transforms 
FU = fftshift(fft2(fxbin));
GU = fftshift(fft2(gxbin));

%Get the magnitude and phase spectrums of both images
Mag_FU = abs(FU);
Mag_FU = log(Mag_FU+1);
Mag_FU = mat2gray(Mag_FU);
Phase_FU = angle(FU);

Mag_GU = abs(GU);
Mag_GU = log(Mag_GU+1);
Mag_GU = mat2gray(Mag_GU);
Phase_GU = angle(GU);

unity = ones(225,225);
empty = zeros(225,225);

%Show the images, phase spectrum, and magnitude spectrum
figure
subplot(2,3,1);imshow(fx);title('Input Image f(x,y)');
hold on 
subplot(2,3,2);imshow(Mag_FU);title('Magnitude Spectra of F(u,v)');
hold on
subplot(2,3,3);imshow(Phase_FU);title('Phase Spectra of F(u,v)');
hold on 
subplot(2,3,4);imshow(gx);title('Input Image g(x,y)');
hold on 
subplot(2,3,5);imshow(Mag_GU);title('Magnitude Spectra of G(u,v)');
hold on
subplot(2,3,6);imshow(Phase_GU);title('Phase Spectra of G(u,v)');
hold off 

%Question 1 - Reconstruct f(x,y) with it's magnitude and phase
Q1 = abs(fxFFT).*exp(1i*angle(fxFFT));
q1 = ifft2(Q1);
q1min = min(min(min(abs(q1))));
q1max = max(max(max(abs(q1))));

%Question 2 - Reconstruct image with magnitude of F(u,v) and phase of G(u,v)
Q2 = abs(fxFFT).*exp(1i*angle(gxFFT));
q2 = ifft2(Q2);
q2min = min(min(min(abs(q2))));
q2max = max(max(max(abs(q2))));

%Question 3 - Reconstruct image with magnitude of G(u,v) and phase of F(u,v)
Q3 = abs(gxFFT).*exp(1i*angle(fxFFT));
q3 = ifft2(Q3);
q3min = min(min(min(abs(q3))));
q3max = max(max(max(abs(q3))));

%Question 4 - Reconstruct image with magnitude of 1 and phase of F(u,v)
Q4 = abs(unity).*exp(1i*angle(fxFFT));
q4 = ifft2(Q4);
q4min = min(min(min(abs(q4))));
q4max = max(max(max(abs(q4))));

%Question 5 - Reconstruct image with the magnitude of G(u,v) of ones and phase of 0
Q5 = abs(gxFFT).*exp(1i*angle(empty));
q5 = ifft2(Q5);
q5min = min(min(min(abs(q5))));
q5max = max(max(max(abs(q5))));

%Question 6 - Reconstruct image with magnitude of zero and phase of G(u,v)
Q6 = abs(empty).*exp(1i*angle(gxFFT));
q6 = ifft2(Q6);
q6min = min(min(min(abs(q6))));
q6max = min(max(max(abs(q6))));

figure();
subplot(2,3,1);imshow(uint8(q1),[q1min q1max]);title('f(x,y) reconstructed');
hold on
subplot(2,3,2);imshow(uint8(q2));title('Mag of F(u,v) & Phase of G(u,v)');
hold on 
subplot(2,3,3);imshow(uint8(q3));title('Mag G(u,v) & Phase of F(u,v)');
hold on 
subplot(2,3,4);imshow(uint8(q4));title('Mag = 1 & Phase of F(u,v)');
hold on
subplot(2,3,5);imshow(uint8(q5));title('Mag of G(u,v) & Phase = 0');
hold on
subplot(2,3,6);imshow(uint8(q6));title('Mag = 0 & Phase of G(u,v)');
