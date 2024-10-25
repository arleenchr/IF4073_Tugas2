image = im2double(imread('images/7-2.jpg'));
imshow(image);

imageOutput = deconvolution(image, true, false, 'Gaussian', 10, 1);
figure; imshow(imageOutput);