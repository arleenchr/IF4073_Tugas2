function [outputImage, fourierSpectrum] = autoPeriodicNoiseReduction(image, notchSize, threshold)
    % Konversi ke grayscale jika berwarna
    if size(image, 3) == 3
        image = rgb2gray(image);
    end
    image = double(image);

    % Hitung FFT
    [rows, cols] = size(image);
    imageFFT = fftshift(fft2(image));
    magnitudeFFT = abs(imageFFT);

    % Compute and normalize the Fourier Spectrum for display
    fourierSpectrum = log(1 + magnitudeFFT);  % Log scale to enhance visibility
    fourierSpectrum = uint8(255 * mat2gray(fourierSpectrum));

    % Deteksi spikes dengan threshold
    noisePeaks = magnitudeFFT > threshold * max(magnitudeFFT(:));
    noisePeaks = noisePeaks .* magnitudeFFT;  % Mask

    % Inisialisasi notch filter mask dengan 1
    notchFilter = ones(rows, cols);

    % Ukuran notch (prediksi)
    %notchSize = 5;
    sigma = notchSize; % gaussian
    %n = 1.5; % butterworth

    centerRow = floor(rows / 2) + 1;
    centerCol = floor(cols / 2) + 1;

    % Iterasi untuk setiap spike yang terdeteksi
    [peakRows, peakCols] = find(noisePeaks);
    for k = 1:length(peakRows)
        row = peakRows(k);
        col = peakCols(k);
        %disp(row);
        %disp(col);
        %disp('---');

        % Skip the center peak (DC component)
        if row > centerRow - notchSize && row < centerRow + notchSize && col > centerCol - notchSize && col < centerCol + notchSize
            continue;
        end
        
        % Buang frekuensi yang mengganggu jadi 0
        %notchFilter(max(row-notchSize,1):min(row+notchSize,rows), ...
        %            max(col-notchSize,1):min(col+notchSize,cols)) = 0;

        % Compute Gaussian mask for each peak
        for i = 1:rows
            for j = 1:cols
                d = sqrt((i - row)^2 + (j - col)^2);
                notchFilter(i, j) = notchFilter(i, j) * (1 - exp(-d^2 / (2 * sigma^2)));
            end
        end

        % Apply Butterworth formula for each peak
        %for i = 1:rows
        %    for j = 1:cols
        %        d = sqrt((i - row)^2 + (j - col)^2);
        %        notchFilter(i, j) = notchFilter(i, j) * (1 / (1 + (d / notchSize)^(2 * n)));
        %    end
        %end
    end

    % Masking ke citra
    filteredFFT = imageFFT .* notchFilter;

    % Invers FFT ke ranah spasial
    filteredImage = real(ifft2(ifftshift(filteredFFT)));

    % Normalisasi dengan range dan intensitas aslinya
    filteredImage = filteredImage - min(filteredImage(:));
    filteredImage = filteredImage * (max(image(:)) / max(filteredImage(:)));
    
    % Convert to uint8 format for display
    outputImage = uint8(filteredImage);
    
    % Normalize and convert back to uint8 format
    %outputImage = uint8(mat2gray(filteredImage) * 255);
end
