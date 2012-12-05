% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function [subimage, centre] = pickSubimage(image, verbose)

if nargin < 2
    imshow(image);
    title('Click on upper-left-corner and lower-right-corner of sub-image.')
    corners = ginput(2);    
elseif verbose
    corners = [412, 350; 434, 400];
end
centre = floor(mean(corners));
subimage = image(corners(1,2):corners(2,2), corners(1,1):corners(2,1), :);
