% Set an appropriate threshold for noise peak detection
threshold = 0.025;  % Adjust based on the intensity of noise

image = imread('images/6-6.png');
%image = imread('images/6-5.jpg');
figure; imshow(image);

%notchSize = 5; % 6-1
notchSize = 10; % 6-2
[filteredImage, fourierSpectrum] = autoPeriodicNoiseReduction(image, notchSize, threshold);
figure; imshow(fourierSpectrum);
figure; imshow(filteredImage);

imageFFT = fftshift(fft2(filteredImage));
magnitudeFFT = abs(imageFFT);

% Compute and normalize the Fourier Spectrum for display
fourierSpectrum = log(1 + magnitudeFFT);  % Log scale to enhance visibility
fourierSpectrum = uint8(255 * mat2gray(fourierSpectrum));
figure; imshow(fourierSpectrum);