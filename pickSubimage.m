% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function [subimage, centre] = pickSubimage(image, player)

if nargin < 2
    imshow(image);
    title('Click on upper-left-corner and lower-right-corner of sub-image.')
    corners = ginput(2);    
elseif strcmp(player, 'player12')
    corners = [412, 350; 434, 400];
elseif strcmp(player, 'upperLeft')
    corners = [55, 191; 72, 228];
elseif strcmp(player, 'dreads')
    corners = [98, 252; 116, 300];
elseif strcmp(player, 'referee')
    corners = [247, 339; 264, 405];
end
centre = floor(mean(corners));
subimage = image(corners(1,2):corners(2,2), corners(1,1):corners(2,1), :);
