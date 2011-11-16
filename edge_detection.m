function imout = edge_detection(imin)
% DESCRIPTION
%   A function that detects edges in an image and returns the result as a
%   new image.

% PARAMETERS
%   IN:
%     imin: The input image of the captured QR-code.
%   OUT:
%     imout: The resulting image containing the edges from the original
%     image.



% Get width and height of image
[height, width] = size(imin);

% Transform image
im_fft = fft2(imin);

% Shift the transformed image
im_fft_shifted = fftshift(im_fft);

% DELETABLE: View fourier spectra
%figure(1)
%imshow(log(1+abs(im_fft_shifted)), []);

% WIP: Create a high-pass filter
[x,y] = meshgrid(-width/2:1:(width/2-1), -height/2:1:(height/2-1));
D = (x.^2 + y.^2).^(1/2);

% Set threshold
D0 = 150;

% Create ideal high-pass
ideal_hpf = D;
ideal_hpf(ideal_hpf<D0) = 0;
ideal_hpf(ideal_hpf>=D0) = 1;

% Create Gaussian high-pass filter
gaussian_hpf = 1 - exp(-(D.^2)/(2.*D0.^2));

hpf = gaussian_hpf;
% /WIP: Create a high-pass filter

% Apply the high-pass filter
im_hpf = im_fft_shifted .* hpf;

% DELETABLE: View high-pass filtered fourier spectra
%figure(2)
%imshow(log(1+abs(im_hpf)), []);

% Copy the last variable which will be inverse transformed
im_to_ifft = im_hpf;
% Shift back the image
im_to_ifft = fftshift(im_to_ifft);

% Inverse transform image
im_ifft = ifft2(im_to_ifft);

% Do some magic to be able to show the image again
imout = real(im_ifft);