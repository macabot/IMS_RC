% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function backproj = histbackproj(scene, hTarget, hScene, bins)

backproj = zeros(size(scene, 1), size(scene, 2));
for i=1:size(scene, 1)
    for j=1:size(scene, 2)
        pu = pixelInHist(scene(i,j,:), hScene, bins);
        qu = pixelInHist(scene(i,j,:), hTarget, bins);
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