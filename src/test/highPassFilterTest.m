image = imread('images/3-2.jpg');
imshow(image);

imageOutput = highPassFilter(image,'Butterworth', 50, 2);
figure; imshow(imageOutput);