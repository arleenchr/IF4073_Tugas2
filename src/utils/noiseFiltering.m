function outputImage = noiseFiltering(image, filter, varargin)
    image = double(image);
    [rows, cols, channels] = size(image); 
    outputImage = zeros(rows, cols, channels);

    % Ukuran window 3x3
    windowSize = 3;
    padSize = floor(windowSize / 2);
    paddedImage = padarray(image, [padSize padSize], 'symmetric');

    % Penapisan untuk tiap kanal warna
    for c = 1:channels
        for i = 1:rows
            for j = 1:cols
                % Ekstrak window untuk channel c
                window = paddedImage(i:i+windowSize-1, j:j+windowSize-1, c);
                window = window(:);  % Ubah window jadi vektor

                switch lower(filter)
                    case 'min'
                        outputImage(i, j, c) = min(window);

                    case 'max'
                        outputImage(i, j, c) = max(window);

                    case 'median'
                        outputImage(i, j, c) = median(window);

                    case 'arithmetic mean'
                        outputImage(i, j, c) = mean(window);

                    case 'geometric mean'
                        outputImage(i, j, c) = prod(window)^(1/numel(window));

                    case 'harmonic mean'
                        outputImage(i, j, c) = numel(window) / sum(1 ./ window);

                    case 'contraharmonic mean'
                        Q = varargin{1};  % Contraharmonic order Q
                        outputImage(i, j, c) = sum(window.^(Q + 1)) / sum(window.^Q);

                    case 'midpoint'
                        outputImage(i, j, c) = (min(window) + max(window)) / 2;

                    case 'alpha-trimmed mean'
                        d = varargin{1};  % Banyaknya elemen yang dipangkas
                        sortedWindow = sort(window);
                        if d >= windowSize / 2
                            warning('Trim value d is too large; setting to zero.');
                            outputImage(i, j, c) = mean(sortedWindow);
                        else
                            trimmedWindow = sortedWindow(d + 1:end - d);
                            outputImage(i, j, c) = mean(trimmedWindow);
                        end

                    otherwise
                        error('Unknown filter type');
                end
            end
        end
    end

    outputImage = uint8(outputImage);
end
