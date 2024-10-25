function outputImage  = saltPepperNoise(image, density)
    outputImage = imnoise(image, 'salt & pepper', density);
end