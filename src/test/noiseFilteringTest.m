image = imread('images/5-1.jpg');
figure; imshow(image);
noisyImage = saltPepperNoise(image, 0.05);
figure; imshow(noisyImage);

%imageOutput = noiseFiltering(noisyImage,'min');
%imageOutput = noiseFiltering(noisyImage,'max');
%imageOutput = noiseFiltering(noisyImage,'median');
%imageOutput = noiseFiltering(noisyImage,'arithmetic mean');
%imageOutput = noiseFiltering(noisyImage,'geometric mean');
%imageOutput = noiseFiltering(noisyImage,'harmonic mean');
%imageOutput = noiseFiltering(noisyImage,'contraharmonic mean', 1.5);
%imageOutput = noiseFiltering(noisyImage,'midpoint');
imageOutput = noiseFiltering(noisyImage,'alpha-trimmed mean', 2);
figure; imshow(imageOutput);