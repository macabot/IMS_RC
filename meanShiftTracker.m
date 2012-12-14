% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function averageDuration = meanShiftTracker(folder, bins)
clf; % clear all images
files = dir(strcat(folder, '/*.png'));
im1 = imread(strcat(folder, '/', files(1).name));
% NOTE: pickSubimage/2 is in debugmode and chooses default subimage
[target, centre] = pickSubimage(im1, 1); % pick target
target = convert(target, '');
yCentre = centre(1);
xCentre = centre(2);
halfWidthScene = size(target,1); % scene-width is 2 times target-width
halfHeightScene = size(target,2); % scene-height is 2 times target-height
% Epanechnikov kernels
parameters = [pi, 2];
kernelTarget = makeKernel(size(target), 'epan', parameters); 
sceneSize = [halfWidthScene*2+1, halfHeightScene*2+1];
kernelScene = makeKernel(sceneSize, 'epan', parameters);
hTarget= normalize(makeHist(target, bins, kernelTarget));
epsilon = 1; % maximal distance between new and previous location

start = cputime; % measure duration of mean-shift
for i=1:numel(files)    
    % read/show image
    figure(1);
    clf;
    im = imread(strcat(folder, '/', files(i).name));
    imshow(im);
    hold on;
    title(files(i).name)
    % find target
    
    
    
    while true 
        scene = im(xCentre-halfWidthScene:xCentre+halfWidthScene, ...
            yCentre-halfHeightScene:yCentre+halfHeightScene, :);
        scene = convert(scene, ''); %im2double
        hScene = normalize(makeHist(scene, bins, kernelScene));
        coef = bhattCoef(hTarget, hScene);
        
        location = meanShift(scene, hScene, hTarget, bins);
        newXCentre = location(1)+xCentre-halfWidthScene;
        newYCentre = location(2)+yCentre-halfHeightScene;
        
        while true
            tempScene = im(newXCentre-halfWidthScene:newXCentre+halfWidthScene, ...
                newYCentre-halfHeightScene:newYCentre+halfHeightScene, :);
            tempScene = convert(tempScene, ''); %im2double
            tempHScene = normalize(makeHist(tempScene, bins, kernelScene));
            tempCoef = bhattCoef(hTarget, tempHScene);
            if tempCoef < coef
                newXCentre = (newXCentre+xCentre)/2;
                newYCentre = (newYCentre+yCentre)/2;
            else
                break;
            end
        end
        
        if distance([xCentre,yCentre], [newXCentre,newYCentre], 'eucl') < epsilon
           break; 
        else
            xCentre = newXCentre;
            yCentre = newYCentre;
        end
    end
    
    % draw match 
    plot(yCentre, xCentre, 'x', 'MarkerSize', 10, 'LineWidth', 3);
    upperLeft = [yCentre-size(target,2)/2, xCentre-size(target,1)/2];
    rectangle('Position', [upperLeft(1), upperLeft(2),...
        size(target,2), size(target,1)])
end
averageDuration = (cputime-start)/numel(files);
hold off;
title('Finished');