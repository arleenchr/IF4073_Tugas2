function fourierSpectrum = showFourier(image)
    imageFFT = fftshift(fft2(image));
    magnitudeFFT = abs(imageFFT);
    
    fourierSpectrum = log(1 + magnitudeFFT);
    fourierSpectrum = uint8(255 * mat2gray(fourierSpectrum));
end