% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function location = meanShift(scene, hScene, hTarget, bins)
% derive weights
weights = histbackproj(scene, hTarget, hScene,  bins);
% find next location of target candidate 
[X,Y] = meshgrid(1:size(scene,2),1:size(scene,1));
xTimesWeights = X.*weights;
yTimesWeights = Y.*weights;
enumeratorX  = sum(xTimesWeights(:)); 
enumeratorY  = sum(yTimesWeights(:));
denominator = sum(weights(:));
if denominator==0
   fprintf('In meanShift/4: sum of weights is 0!\n'); 
end

location = [round(enumeratorY/denominator), ...
    round(enumeratorX/denominator)];