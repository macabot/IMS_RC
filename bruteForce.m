% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function bruteForce(folder, bins)
clf; % clear all images
files = dir(strcat(folder, '/*.png'));
im1 = imread(strcat(folder, '/', files(1).name));
% NOTE: pickSubimage/2 is in debugmode and chooses default subimage
[target, centre] = pickSubimage(im1, 1); % pick target
xCentre = centre(1);
yCentre = centre(2);
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