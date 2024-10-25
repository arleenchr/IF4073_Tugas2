image = imread('images/2-1.jpg');
imshow(image);

imageOutput = lowPassFilter(image,'Butterworth', 50, 2);
figure; 
imshow(imageOutput);