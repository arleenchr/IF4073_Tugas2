I = im2double(imread('images/7-1.jpg'));
imshow(I);

LEN = 40; THETA = 10;
PSF = fspecial('motion', LEN, THETA);
blurred = motionBluring(I,PSF);
%blurred = I;

noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);
figure, imshow(blurred_noisy);
title('Blurred Image with noise');

estimated_nsr = 0;
%wnr2 = deconvwnr(blurred, PSF, estimated_nsr);
wnr2 = wiener(blurred, PSF, estimated_nsr);
figure, imshow(wnr2)
title('Restoration of Blurred, Noisy Image Using NSR = 0')

signal_variance = var(I(:)); % Hitung variansi sinyal
if signal_variance > 0
    estimated_nsr = noise_var / signal_variance;
else
    estimated_nsr = noise_var; % Gunakan nilai default jika variansi sinyal terlalu kecil
end
%wnr3 = deconvwnr(blurred_noisy, PSF, estimated_nsr);
wnr3 = wiener(blurred_noisy, PSF, estimated_nsr);
figure, imshow(wnr3)

figure; imshow(imabsdiff(I, wnr2));
title('Perbedaan citra asli dengan citra restorasi')
