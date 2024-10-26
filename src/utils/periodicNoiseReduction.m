function outputImage = periodicNoiseReduction(image, notchRanges)
    % Convert to grayscale if the image is colored
    if size(image, 3) == 3
        image = rgb2gray(image);
    end
    image = double(image);

    % Get the image size and compute the FFT
    [rows, cols] = size(image);
    imageFFT = fftshift(fft2(image));  % Center FFT for visualization and manipulation

    % Create a notch filter mask initialized to ones
    notchFilter = ones(rows, cols);

    % Loop over each specified notch range and create a notch filter
    for k = 1:size(notchRanges, 1)
        colRange = notchRanges{k, 1};  % Column range
        rowRange = notchRanges{k, 2};  % Row range
        
        % Zero out the frequencies in the specified ranges
        notchFilter(rowRange(1):rowRange(2), colRange(1):colRange(2)) = 0;
        notchFilter(end-rowRange(2):end-rowRange(1), end-colRange(2):end-colRange(1)) = 0;
    end

    % Apply the notch filter to the FFT of the image
    filteredFFT = imageFFT .* notchFilter;

    % Inverse FFT to transform back to spatial domain
    filteredImage = real(ifft2(ifftshift(filteredFFT)));
    
    % Normalize and convert back to uint8 format
    outputImage = uint8(mat2gray(filteredImage) * 255);
end
