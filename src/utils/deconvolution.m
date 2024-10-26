function outputImage = deconvolution(image, needBluring, noise, PSF, LEN, blurEffect)
    %Lakukan bluring
    if needBluring
        blurred = imfilter(image, PSF, 'conv', 'circular');
    else
        blurred = image; 
    end
    
    % Tambahkan noise jika diperlukan
    if noise
        noise_mean = 0;
        noise_var = 0.0001;
        blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);
    else
        blurred_noisy = blurred; 
    end

    % Restorasi dengan dekonvolusi Wiener
    % Hitung estimated_nsr berdasarkan ada atau tidaknya noise
    if noise
        signal_variance = var(image(:)); % Hitung variansi sinyal dari gambar asli
        if signal_variance > 0
            estimated_nsr = noise_var / signal_variance;
        else
            estimated_nsr = noise_var; % Gunakan nilai default jika variansi sinyal terlalu kecil
        end
    else
        estimated_nsr = 0; % Asumsi tanpa noise
    end
    
    % Lakukan dekonvolusi dengan fungsi Wiener
    outputImage = wiener(blurred_noisy, PSF, estimated_nsr,LEN,blurEffect);
end
