% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function [subimage, centre] = pickSubimage(image, player)

if strcmp(player, '')
    imshow(image);
    title('Click on upper-left-corner and lower-right-corner of sub-image.')
    corners = ginput(2);
    fprintf('corners = [%d, %d; %d, %d]\n', corners(1,1), corners(1,2),...
        corners(2,1), corners(2,2));
elseif strcmp(player, 'player12')
    corners = [412, 350; 434, 400];
elseif strcmp(player, 'upperLeft')
    corners = [55, 191; 72, 228];
elseif strcmp(player, 'upperLeft2')
    corners = [60, 200; 66, 211];
elseif strcmp(player, 'dreads')
    corners = [98, 252; 116, 300];
elseif strcmp(player, 'dreads2')
    corners = [104, 261; 110, 275];
elseif strcmp(player, 'referee')
    corners = [247, 339; 264, 405];
elseif strcmp(player, 'blue')
    corners = [324, 272; 334, 317];
end
centre = floor(mean(corners));
subimage = image(corners(1,2):corners(2,2), corners(1,1):corners(2,1), :);
