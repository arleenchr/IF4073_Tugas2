function outputImage = autoPeriodicNoiseReduction(image, notchSize, threshold)
    % Konversi ke grayscale jika berwarna
    if size(image, 3) == 3
        image = rgb2gray(image);
    end
    image = double(image);

    % Hitung FFT
    [rows, cols] = size(image);
    imageFFT = fftshift(fft2(image));
    magnitudeFFT = abs(imageFFT);

    % Deteksi spikes dengan threshold
    noisePeaks = magnitudeFFT > threshold * max(magnitudeFFT(:));
    noisePeaks = noisePeaks .* magnitudeFFT;  % Mask

    % Inisialisasi notch filter mask dengan 1
    notchFilter = ones(rows, cols);

    sigma = notchSize; % gaussian

    centerRow = floor(rows / 2) + 1;
    centerCol = floor(cols / 2) + 1;

    % Iterasi untuk setiap spike yang terdeteksi
    [peakRows, peakCols] = find(noisePeaks);
    for k = 1:length(peakRows)
        row = peakRows(k);
        col = peakCols(k);

        % Melewati spike di tengah
        if abs(row - centerRow) < notchSize && abs(col - centerCol) < notchSize
            continue;
        end
        
        % Menghitung penapisan Gaussian
        for i = 1:rows
            for j = 1:cols
                d = sqrt((i - row)^2 + (j - col)^2);
                notchFilter(i, j) = notchFilter(i, j) * (1 - exp(-d^2 / (2 * sigma^2)));
            end
        end
    end

    % Masking ke citra
    filteredFFT = imageFFT .* notchFilter;

    % Invers FFT ke ranah spasial
    filteredImage = real(ifft2(ifftshift(filteredFFT)));

    % Normalisasi dengan range dan intensitas aslinya
    filteredImage = filteredImage - min(filteredImage(:));
    filteredImage = filteredImage * (255 / max(filteredImage(:)));
    
    % Convert to uint8 format for display
    outputImage = uint8(filteredImage);
end
