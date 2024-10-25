function outputImage = deconvolution(image, needBluring, noise, blurEffect, LEN, THETA)
    % Definisikan PSF berdasarkan jenis blur yang diinginkan
    if strcmp(blurEffect, 'Motion')
        PSF = fspecial('motion', LEN, THETA);
    elseif strcmp(blurEffect, 'Gaussian')
        PSF = fspecial('gaussian', LEN, THETA); % Parameter THETA diabaikan untuk Gaussian
    else
        error('blurEffect harus bernilai "motion" atau "gaussian".');
    end

    % Step 1: Lakukan pemburaman jika diperlukan
    if needBluring
        blurred = imfilter(image, PSF, 'conv', 'circular');
    else
        blurred = image; % Jika tidak perlu blurring, langsung gunakan gambar asli
    end
    
    % Step 2: Tambahkan noise jika diperlukan
    if noise
        noise_mean = 0;
        noise_var = 0.0001;
        blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);
    else
        blurred_noisy = blurred; % Jika tidak ada noise, gunakan gambar blur saja
    end

    % Step 3: Restorasi dengan dekonvolusi Wiener
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
