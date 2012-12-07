function location = meanShift(scene, hTarget, bins)


hScene = normalize(makeHist(scene, bins));
weights = histbackproj(scene, hTarget, hScene,  bins)

[X,Y] = meshgrid(size(scene,2),size(scene,1));

Z(:,:,1) = X;
Z(:,:,2) = Y;

enumeratorX  = sum(sum(X .*weights,1),2); 
enumeratorY  = sum(sum(Y .*weights,1),2);
demoninator = sum(weights(:));


location = [enumeratorX / demoninator, enumeratorY/ demoninator];