function backproj = histbackproj(scene, hTarget, hScene,  bins)
% originalScene = scene;
scene = convert(scene, '');
%target = convert(target, '');

% minRange = min(min(target));
% minRange = [minRange(1,1,1), minRange(1,1,2), minRange(1,1,3)];
% maxRange = max(max(target));
% maxRange = [maxRange(1,1,1), maxRange(1,1,2), maxRange(1,1,3)];
% stepSize = (maxRange-minRange)/bins;
% range = minRange:stepSize:maxRange;
% size(target)
% size(range)


if strcmp(class(scene), 'uint8')
    step = 255/bins;
else
    step = 1.0/bins;
end

backproj = zeros(size(scene, 1), size(scene, 2));
for i=1:size(scene, 1)
    for j=1:size(scene, 2)
        pu = pixelInHist(scene(i,j,:), hScene, step);
        qu = pixelInHist(scene(i,j,:), hTarget, step);
        if pu == 0
            backproj(i,j)=0;
        else
            backproj(i,j) = sqrt(qu/pu);
        end
        
    end
end
    

% [x,y] = find(backproj==(max(max(backproj))))
% plot(y, x, 'go', 'MarkerSize', 50, 'LineWidth',4);
% %backproj = bsxfun(@pixelInHist, scene, [h, stepSize]);