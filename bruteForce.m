% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function bruteForce(folder, bins)
clf; % clear all images
files = dir(strcat(folder, '/*.png'));
im1 = imread(strcat(folder, '/', files(1).name));
% NOTE: pickSubimage/2 is in debugmode and chooses default subimage
[target, centre] = pickSubimage(im1, 1); % pick target
yCentre = centre(1);
xCentre = centre(2);
halfWidthScene = size(target,1); % scene-width is 2 times target-width
halfHeightScene = size(target,2); % scene-height is 2 times target-height

distType = 'bhatt'; % bhattacharyya distance
for i=1:numel(files)
    figure(1);
    clf;
    % read/show image
    im = imread(strcat(folder, '/', files(i).name));
    imshow(im);
    hold on;
    title(files(i).name)
    % find target
    scene = im(xCentre-halfWidthScene:xCentre+halfWidthScene, ...
        yCentre-halfHeightScene:yCentre+halfHeightScene, :);
    [xNew,yNew] = findTarget(scene, target, bins, distType);
    xCentre = xNew+xCentre-halfWidthScene;
    yCentre = yNew+yCentre-halfHeightScene;
    % draw match 
    plot(yCentre, xCentre, 'x', 'MarkerSize', 10, 'LineWidth', 3);
    upperLeft = [yCentre-size(target,2)/2, xCentre-size(target,1)/2];
    rectangle('Position', [upperLeft(1), upperLeft(2),...
        size(target,2), size(target,1)])
end
hold off;
title('Finished');