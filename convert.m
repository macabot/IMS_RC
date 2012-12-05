% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function conversion = convert(image, type)

if strcmp(class(image), 'uint8')
    image = im2double(image); % also rescales image between 0 and 1
    %image = double(image);
    conversion = image;
end

r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);
    
if strcmp(type, 'rgb2rgbNormalized') % rgb doubles to normalized rgb
    total = r+g+b;
    conversion(:,:,1) = r./total;
    conversion(:,:,2) = g./total;
    conversion(:,:,3) = b./total;
elseif strcmp(type, 'rgb2opponent')
    conversion(:,:,1) = (r-g)/sqrt(2);
    conversion(:,:,2) = (r+g-2*b)/sqrt(6);
    conversion(:,:,3) = (r+g+b)/sqrt(3);
elseif strcmp(type, 'rgb2hsv')
    conversion = rgb2hsv(image);
end

conversion(isnan(conversion)) = 0;