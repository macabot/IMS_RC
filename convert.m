% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function conversion = convert(image, type)

if strcmp(class(image), 'uint8')
    image = im2double(image); % also rescales image between 0 and 1
    conversion = image;
end

r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);
    
if strcmp(type, 'rgb2rgbNormalized')
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
elseif strcmp(type, 'rgb2hue')
    conversion = rgb2hsv(image);
    conversion(:,:,2) = 0; % throw away saturation
    conversion(:,:,3) = 0; % throw away value
end

conversion(isnan(conversion)) = 0;