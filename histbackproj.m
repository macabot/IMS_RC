function histbackproj(scene, target, bins)
originalScene = scene;
scene = convert(scene, '');
target = convert(target, '');

% minRange = min(min(target));
% minRange = [minRange(1,1,1), minRange(1,1,2), minRange(1,1,3)];
% maxRange = max(max(target));
% maxRange = [maxRange(1,1,1), maxRange(1,1,2), maxRange(1,1,3)];
% stepSize = (maxRange-minRange)/bins;
% range = minRange:stepSize:maxRange;
% size(target)
% size(range)
h = makeHist(target, bins,'');%range);

backproj = zeros(size(scene, 1), size(scene, 2));
for i=1:size(scene, 1)
    for j=1:size(scene, 2)
        backproj(i,j) = pixelInHist(scene(i,j,:), h, 255/bins);
    end
end
    
figure();
imshow(originalScene);
hold on;
[x,y] = find(backproj==(max(max(backproj))))
plot(y, x, 'go', 'MarkerSize', 50, 'LineWidth',4);
%backproj = bsxfun(@pixelInHist, scene, [h, stepSize]);