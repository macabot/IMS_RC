% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function [all_frames, averageDuration, error] = bruteForce(folder, bins, groundTruth)
clf; % clear all images
files = dir(strcat(folder, '/*.png'));
im1 = imread(strcat(folder, '/', files(1).name));

[target, centre] = pickSubimage(im1, 'upperLeft'); % pick target
yCentre = centre(1);
xCentre = centre(2);
halfWidthScene = size(target,1); % scene-width is 2 times target-width
halfHeightScene = size(target,2); % scene-height is 2 times target-height

all_frames(1:numel(files)) = struct('cdata', [], 'colormap', []); % images with location of tracked object
errorSum = 0;

kernel = makeKernel(size(target), 'epan', [pi, 2]); % Epanechnikov kernel
distType = 'bhatt'; % bhattacharyya distance
start = cputime; % measure duration of mean-shift
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
    [xNew,yNew] = findTarget(scene, target, bins, distType, kernel);
    xCentre = xNew+xCentre-halfWidthScene;
    yCentre = yNew+yCentre-halfHeightScene;
    errorSum = errorSum + distance(groundTruth(i,:), [yCentre, xCentre], 'eucl');
    % draw match 
    plot(groundTruth(i,1), groundTruth(i,2), 'gx', 'MarkerSize', 10', 'LineWidth', 3);
    plot(yCentre, xCentre, 'x', 'MarkerSize', 10, 'LineWidth', 3);
    upperLeft = [yCentre-size(target,2)/2, xCentre-size(target,1)/2];
    rectangle('Position', [upperLeft(1), upperLeft(2),...
        size(target,2), size(target,1)]);
    rectangle('Position', [yCentre-size(scene,2)/2, ...
        xCentre-size(scene,1)/2, size(scene,2), size(scene,1)]);
    
    all_frames(i) = getframe(gcf); % save frame
end
averageDuration = (cputime-start)/numel(files);
error = errorSum / numel(files);
hold off;
title('Finished');