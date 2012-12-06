% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function [x,y] = findTarget(scene, target, bins, distType )
% normalize images
searchSpace = convert(scene,'');
target = convert(target,'');
% target histogram
hTarget = makeHist(target, bins);
nhTarget = normalize(hTarget);
% search for target
distanceMap = zeros(size(scene,1),size(scene,2));
for i = 1:size(scene,1)-size(target,1)
    for j = 1:size(scene,2)-size(target,2)
        subSpace = searchSpace(i:i+size(target,1)-1, j:j+size(target,2)-1, :);
        hSub = makeHist(subSpace, bins);
        nhSub = normalize(hSub);
        dist = histDist(nhTarget, nhSub, distType);
        xPos = i+floor(size(target,1)/2);
        yPos = j+floor(size(target,2)/2);
        distanceMap(xPos, yPos) = 1 - dist; % 0 distance is white
    end
end
% target position is rounded average of points with smallest distance
[xMax, yMax] = find(distanceMap==(max(max(distanceMap))));
targetPos = round(mean([xMax, yMax], 1)); 
x = targetPos(1);
y = targetPos(2);