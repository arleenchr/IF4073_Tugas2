function outputImage = brightening(image)
    [rows, cols, colorChannels] = size(image);
 
    % Menentukan parameter padding, biasanya P = 2*rows dan Q = 2*cols
    P = 2*rows;
    Q = 2*cols;
    tempImage = zeros([P Q colorChannels]);

    image = im2double(image);
    fp = zeros([P Q colorChannels]);

    % proses
    for c = 1:colorChannels
        for i = 1 : P
            for j = 1 : Q
                if i <= rows && j <= cols
                    fp(i,j,c) = image(i,j,c);
                else
                    fp(i,j,c) = 0;
                end
            end
        end
    end

    for c = 1:colorChannels
        currImg = fp(:,:,c);

        % transformasi fourier
        F = fftshift(fft2(currImg));

        radius = 100;                  % Tentukan radius untuk memodifikasi komponen frekuensi rendah
        centerX = P / 2;
        centerY = Q / 2;
        brightness_factor = 2;      % Faktor untuk meningkatkan kecerahan (sesuaikan nilainya)
        
        for i = 1:P
            for j = 1:Q
                distance = sqrt((i - centerX)^2 + (j - centerY)^2);
                if distance < radius
                    F(i, j) = F(i, j) * brightness_factor;
                end
            end
        end
        
        F2 = ifftshift(F);
        Freal = real(ifft2(F2));

        tempImage(:,:,c) = Freal(:,:,1);
    end



    outputImage = tempImage(1:rows, 1:cols, :);
end