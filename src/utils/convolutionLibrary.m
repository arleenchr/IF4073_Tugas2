function outputImage = convolutionLibrary(image, mask)
    outputImage = uint8(convn(double(image), double(mask)));
end