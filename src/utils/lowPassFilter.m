function outputImage = lowPassFilter(image, filter, d0, nInput)
    [rows, cols, colorChannels] = size(image);

    disp(filter);
    % Menentukan parameter padding, biasanya P = 2*rows dan Q = 2*cols
    P = 2*rows;
    Q = 2*cols;
    tempImage = zeros([P Q colorChannels]);

    image = im2double(image);
    fp = zeros([P Q colorChannels]);

    % Melakukan padding dengan nilai 0 untuk pixel di luar image awal
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

    % Pemrosesan untuk tiap kanal warna
    for c = 1:colorChannels
        currImg = fp(:,:,c);

        % Transformasi Fourier
        F = fftshift(fft2(currImg));

        % Cut-off frequency
        D0 = d0;

        % Range dari variabel
        u = 0:(P-1);
        v = 0:(Q-1);

        % Index untuk digunakan pada meshgrid
        idx = find(u > P/2);
        u(idx) = u(idx) - P;
        idy = find(v > Q/2);
        v(idy) = v(idy) - Q;

        % Menghitung meshgrid array
        [V, U] = meshgrid(v, u);
        D = sqrt(U.^2 + V.^2);

        H = 0;

        % Melakukan filtering berdasarkan jenis filter low-pass
        if filter == "Gaussian"
            H = exp(-(D.^2)./(2*(D0^2)));
        elseif filter == "Ideal"
            H = double(D <= D0);
        elseif filter == "Butterworth"
            n = nInput;
            H = 1 ./ (1 + (D ./ D0).^(2*n));
        end

        H = fftshift(H);
        G = H .* F;
        G1 = ifftshift(G);
        G2 = real(ifft2(G1));

        tempImage(:,:,c) = G2(:,:,1);
    end

    outputImage = tempImage(1:rows, 1:cols, :);
end
