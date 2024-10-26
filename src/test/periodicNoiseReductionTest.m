%notchRanges = { [50, 60], [175, 185];
%                [70, 80], [190, 210];
%                [180, 190], [50, 60];
%                [180, 190], [175, 185];
%                [180, 190], [305, 315];
%                [195, 210], [70, 80];
%                [195, 210], [190, 210];
%                [195, 210], [325, 335];
%                [305, 315], [175, 185];
%                [320, 335], [190, 210]; };

image = imread('images/6-1.png');
figure; imshow(image);
filteredImage = periodicNoiseReduction(image, notchRanges);
figure; imshow(filteredImage);
