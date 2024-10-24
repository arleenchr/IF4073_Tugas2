function outputImage  = motionBluring(image, psf)
    outputImage = imfilter(image,psf,'conv','circular');
end