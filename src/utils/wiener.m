function outputImage = wiener(image, PSF, k)
    image = im2double(image);
    PSF = im2double(PSF);
    
    % Ubah ke bentuk frekuensi fourier
    freqImage = fft2(image);
    freqPSF = fft2(PSF, size(image,1), size(image,2));

    % Dekonvolusi Wiener
    wienerFilter = (conj(freqPSF) ./ (abs(freqPSF).^2 + k));
    F = freqImage .* wienerFilter;

    % Invers
    inverseImage = ifft2(F);
    realImage = real(inverseImage);

    outputImage = max(0, min(1, realImage));
end
