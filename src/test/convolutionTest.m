image = imread('images/1-1.jpg');
imshow(image);

G = 1/25 * [1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1];
H = [0 -1 0; -1 4 -1; 0 -1 0];
conv_image = convolution(double(image), double(G));
figure; imshow(conv_image);

Ifiltered = uint8(convn(double(image), double(G)));
figure; imshow(Ifiltered)
