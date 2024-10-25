image = imread('images/2-1.jpg');
imshow(image);

imageOutput = spatialSmooth(image,'Gaussian', 5, 1.5);
figure; 
imshow(imageOutput);