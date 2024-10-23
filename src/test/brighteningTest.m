image = imread('images/4-2.jpg');
imshow(image);

imageOutput = brightening(image);
figure; imshow(imageOutput);