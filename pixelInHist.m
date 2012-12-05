function intensity = pixelInHist(pixel, hist, stepSize)

pixel = [pixel(:,:,1),pixel(:,:,2),pixel(:,:,3)];
pixel(pixel==0) = 1;
index = ceil(pixel./stepSize);
intensity = hist(index(1),index(2),index(3));