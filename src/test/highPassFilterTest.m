image = imread('images/3-2.jpg');
imshow(image);

imageOutput = highPassFilter(image,'Gaussian');
figure; imshow(imageOutput);