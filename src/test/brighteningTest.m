image = imread('images/4-2.jpg');
imshow(image);

imageOutput = brightening(image,4);
figure; imshow(imageOutput);