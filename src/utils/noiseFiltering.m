function outputImage = noiseFiltering(image, filter, varargin)
    image = double(image);
    [rows, cols] = size(image);
    outputImage = zeros(rows, cols);

    % Ukuran window 3x3
    windowSize = 3;
    padSize = floor(windowSize / 2);
    paddedImage = padarray(image, [padSize padSize], 'symmetric');

    % Penapisan
    for i = 1:rows
        for j = 1:cols
            % Ekstrak window
            window = paddedImage(i:i+windowSize-1, j:j+windowSize-1);
            window = window(:);  % Ubah window jadi vektor

            switch lower(filter)
                case 'min'
                    outputImage(i, j) = min(window);

                case 'max'
                    outputImage(i, j) = max(window);

                case 'median'
                    outputImage(i, j) = median(window);

                case 'arithmetic mean'
                    outputImage(i, j) = mean(window);

                case 'geometric mean'
                    outputImage(i, j) = prod(window)^(1/numel(window));

                case 'harmonic mean'
                    outputImage(i, j) = numel(window) / sum(1 ./ window);

                case 'contraharmonic mean'
                    Q = varargin{1};  % Contraharmonic order Q
                    outputImage(i, j) = sum(window.^(Q + 1)) / sum(window.^Q);

                case 'midpoint'
                    outputImage(i, j) = (min(window) + max(window)) / 2;

                case 'alpha-trimmed mean'
                    d = varargin{1};  % Banyaknya elemen yang dipangkas
                    sortedWindow = sort(window);
                    trimmedWindow = sortedWindow(d + 1:end - d);
                    outputImage(i, j) = mean(trimmedWindow);

                otherwise
                    error('Unknown filter type');
            end
        end
    end

    outputImage = uint8(outputImage);
end
