% Richard Rozeboom (6173292) and Michael Cabot (6047262)

% n = number of bins
function pixelFrequency = pixelInHist(pixel, hist, n)
if strcmp(class(pixel), 'uint8')
    step = 255/n;
else
    step = 1.0/n;
end
cell_no = ceil(pixel/step); % numbers of cells for all pixels
% cell_no can be computed as 0, so we assing them to the first cell
cell_no(cell_no==0) = 1; 
% computing to which index belong the data
a = cell_no(:,:,1) - 1;
b = cell_no(:,:,2) - 1;
c = cell_no(:,:,3) - 1;
index = n * a +n^2 *b + c + 1;
% reshape hist to get frequency of index
histColumn = reshape(hist, n^3, 1);
pixelFrequency = histColumn(index);
