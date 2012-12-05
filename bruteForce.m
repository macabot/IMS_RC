function bruteForce(folder, bins)
clf; % clear all images
files = dir(strcat(folder, '/*.png'));
im1 = imread(strcat(folder, '/', files(1).name));
figure(1)
imshow(im1)
title('Click on upper-left-corner and lower-right-corner of target')
corners = ginput(2);
centre = floor(mean(corners));
xCentre = centre(1);
yCentre = centre(2);

target = im1(corners(1,2):corners(2,2), corners(1,1):corners(2,1), :);
halfWidthScene = size(target,1);
halfHeightScene = size(target,2);

distType = 'batt';
for i=1:numel(files)
    figure(1);
    clf;
    hold on;
    % read/show image
    im = imread(strcat(folder, '/', files(i).name));
    imshow(im);
    title(files(i).name)
    % find target
    scene = im(yCentre-halfWidthScene:yCentre+halfWidthScene, ...
        xCentre-halfHeightScene:xCentre+halfHeightScene, :);
    [xNew,yNew] = findTarget(scene, target, bins, distType);
    xCentre = xNew+xCentre-halfWidthScene;
    yCentre = yNew+yCentre-halfHeightScene;
    % draw match    
    upperLeft = [xCentre-size(target,2)/2, yCentre-size(target,1)/2];
    rectangle('Position', [upperLeft(1), upperLeft(2),...
        size(target,2), size(target,1)])
end
hold off;