function [x,y] = findTarget(scene, target, bins, distType )
searchSpace = convert(scene,'');
target = convert(target,'');

hTarget = makeHist(target, bins, '');
nhTarget = normalize(hTarget);

% halfTargetWidth = floor(size(target, 1)/2);
% halfTargetHeight = floor(size(target,2)/2);


%[halfTargetWidth+1,size(scene,1)-halfTargetWidth]
%[halfTargetHeight+1,size(scene,2)-halfTargetHeight]
%backproj = zeros(size(scene, 1), size(scene, 2));
% for i=halfTargetWidth+1:size(scene,1)-halfTargetWidth-1
%     for j=halfTargetHeight+1:size(scene,2)-halfTargetHeight-1
%         subSpace = searchSpace( i-halfTargetWidth:i+halfTargetHeight,...
%            j-halfTargetHeight:j+halfTargetHeight,:);
%         hSub = makeHist(subSpace,bins,'');
%         nhSub = normalize(hSub);
%         dist = histDist(nhTarget,nhSub,'batt');
%         distanceMap(i,j) = dist; 
%     end
% end

distanceMap = zeros(size(scene,1),size(scene,2));
for i = 1:size(scene,1)-size(target,1)
    for j = 1:size(scene,2)-size(target,2)
        subSpace = searchSpace(i:i+size(target,1)-1, j:j+size(target,2)-1, :);
        hSub = makeHist(subSpace, bins, '');
        nhSub = normalize(hSub);
        dist = histDist(nhTarget, nhSub, distType);
        xPos = i+floor(size(target,1)/2);
        yPos = j+floor(size(target,2)/2);
        distanceMap(xPos, yPos) = 1 - dist; % 0 distance is white
    end
end
 
[x,y] = find(distanceMap==(max(max(distanceMap))));