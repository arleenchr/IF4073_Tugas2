function smoothedImage = spatialSmooth(image, filter, filterSize, sigma)
    % Membuat mean filter n x n berdasarkan jenis filter
    if lower(filter) == "mean"
        kernel = ones(filterSize) / (filterSize * filterSize);
    elseif lower(filter) == "gaussian"
        [x, y] = meshgrid(-(filterSize-1)/2:(filterSize-1)/2, -(filterSize-1)/2:(filterSize-1)/2);
        kernel = exp(-(x.^2 + y.^2) / (2 * sigma^2));
        kernel = kernel / sum(kernel(:));  % Normalisasi filter
    end
    
    % Melakukan konvolusi
    smoothedImage = convolution(image, kernel);
end