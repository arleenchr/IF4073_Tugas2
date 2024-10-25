function outputImage = wiener(image, PSF, k, len, blurEffect)
    temp = zeros(size(image,1), size(image,2), 'double');
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

    img = max(0, min(1, realImage));
    
    % Memperbaiki pixel yang bergeser
    if (strcmp(blurEffect,'Motion'))
        for i = 1:size(img,1)
            for j = 1:size(img,2)
                for k = 1:size(img,3)
                    rows = i;
                    cols = mod(j + len/2,size(img,2));
    
                    if rows == 0
                        rows = rows + size(img,1);
                    end
    
                    if cols == 0
                        cols = cols + size(img,2);
                    end
                    
                    temp(rows,cols,k) = double(img(i,j,k));
                    
                end
            end
        end
    else
        for i = 1:size(img,1)
            for j = 1:size(img,2)
                for k = 1:size(img,3)
                    rows = mod(i + floor(len/2),size(img,1));
                    cols = mod(j + floor(len/2),size(img,2));
    
                    if rows == 0
                        rows = rows + size(img,1);
                    end
    
                    if cols == 0
                        cols = cols + size(img,2);
                    end
                    
                    temp(rows,cols,k) = double(img(i,j,k));
                    
                end
            end
        end
    end

    outputImage = temp;

end
