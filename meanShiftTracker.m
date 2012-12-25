% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function [frames, averageDuration, error] = meanShiftTracker(folder, bins, ...
    groundTruth, player, colorSpace)
clf; % clear all images
files = dir(strcat(folder, '/*.png'));
im1 = imread(strcat(folder, '/', files(1).name));
im1 = convert(im1, colorSpace);
% pickSubimage/2 chooses default subimage
[target, centre] = pickSubimage(im1, player); % pick target
%target = convert(target, colorSpace);
yCentre = centre(1);
xCentre = centre(2);
halfWidthScene = size(target,1); % scene-width is 2 times target-width
halfHeightScene = size(target,2); % scene-height is 2 times target-height
% Epanechnikov kernels
parameters = [pi, 2];
kernelTarget = makeKernel(size(target), 'epan', parameters); 
sceneSize = [halfWidthScene*2+1, halfHeightScene*2+1];
kernelScene = makeKernel(sceneSize, 'epan', parameters);
hTarget= normalize(makeHist(target, bins, kernelTarget)); % target histogram
epsilon = 2; % maximal distance between new and previous location

% images with location of tracked object
frames(1:numel(files)) = struct('cdata', [], 'colormap', []); 
errorSum = 0;

start = cputime; % measure duration of mean-shift
for i=1:numel(files)    
    % read/show image
    figure(1);
    clf;
    im = imread(strcat(folder, '/', files(i).name));
    im = convert(im, colorSpace);
    imshow(im);
    hold on;
    title(files(i).name)
    % find target  
    while true 
        scene = im(xCentre-halfWidthScene:xCentre+halfWidthScene, ...
            yCentre-halfHeightScene:yCentre+halfHeightScene, :);
        %scene = convert(scene, colorSpace); 
        hScene = normalize(makeHist(scene, bins, kernelScene));
        coef = bhattCoef(hTarget, hScene);
        
        location = meanShift(scene, hScene, hTarget, bins);
        newXCentre = location(1)+xCentre-halfWidthScene;
        newYCentre = location(2)+yCentre-halfHeightScene;
        %fprintf('Centre: %f, %f\n', newXCentre, newYCentre);
        
        while true
            tempScene = im(newXCentre-halfWidthScene:newXCentre+halfWidthScene, ...
                newYCentre-halfHeightScene:newYCentre+halfHeightScene, :);
            %tempScene = convert(tempScene, colorSpace); 
            tempHScene = normalize(makeHist(tempScene, bins, kernelScene));
            tempCoef = bhattCoef(hTarget, tempHScene);
            if tempCoef < coef
                tempX = round((newXCentre+xCentre)/2);
                tempY = round((newYCentre+yCentre)/2);
                if tempX==newXCentre && tempY==newYCentre
                    break;
                else
                    newXCentre = tempX;
                    newYCentre = tempY;
                end
            else
                break;
            end
        end
        
        if distance([xCentre,yCentre], [newXCentre,newYCentre], 'eucl') <= epsilon
           break; 
        else
            xCentre = newXCentre;
            yCentre = newYCentre;
        end
    end
    
    errorSum = errorSum + distance(groundTruth(i,:), [yCentre, xCentre], 'eucl');
    % draw match 
    plot(groundTruth(i,1), groundTruth(i,2), 'gx', 'MarkerSize', 10', 'LineWidth', 3);
    plot(yCentre, xCentre, 'x', 'MarkerSize', 10, 'LineWidth', 3);
    upperLeft = [yCentre-size(target,2)/2, xCentre-size(target,1)/2];
    rectangle('Position', [upperLeft(1), upperLeft(2),...
        size(target,2), size(target,1)]);
    rectangle('Position', [yCentre-size(scene,2)/2, ...
        xCentre-size(scene,1)/2, size(scene,2), size(scene,1)]);
    
    frames(i) = getframe(gcf); % save frame
end
averageDuration = (cputime-start)/numel(files);
error = errorSum / numel(files);
hold off;
title('Finished');