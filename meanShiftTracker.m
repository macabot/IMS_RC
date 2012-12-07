function meanShiftTracker(folder, bins)
clf; % clear all images
files = dir(strcat(folder, '/*.png'));
im1 = imread(strcat(folder, '/', files(1).name));
% NOTE: pickSubimage/2 is in debugmode and chooses default subimage
[target, centre] = pickSubimage(im1, 1); % pick target
yCentre = centre(1);
xCentre = centre(2);
halfWidthScene = size(target,1); % scene-width is 2 times target-width
halfHeightScene = size(target,2); % scene-height is 2 times target-height

hTarget= normalize(makeHist(target, bins));


kernel = makeKernel(size(target), 'epan', [pi, 2]); % Epanechnikov kernel
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
   
    coef = bhattCoef(hTarget, hScene)
    
    % TODO
    % draw match 
    % TODO
end
hold off;
title('Finished');