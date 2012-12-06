% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function kernel = makeKernel(size, type, parameters)
size = size-1;
[X, Y] = meshgrid(-size(2)/2:size(2)/2, -size(1)/2:size(1)/2);
X = X/max(X(:)); % normalize by width and height
Y = Y/max(Y(:));
distances = sqrt(X.^2+Y.^2);
if strcmp(type, 'epan') % Epanechnikov kernel
    c = parameters(1);
    d = parameters(2);
    kernel = (0.5/c)*(d+2)*(1-distances);
    kernel(distances>1) = 0;
end