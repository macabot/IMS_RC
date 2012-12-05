% Based on code by Pavel Rajmic
% Modified by Richard Rozeboom & Michael Cabot
% See http://www.mathworks.com/matlabcentral/fileexchange/38685
%
% im = image
% n = amount of bins

function freq = makeHist(im, n, colorSpace)

%% Assigning the pixels to the histogram cells
%disp('Assigning the pixels to the histogram cells...');
if strcmp(class(im), 'uint8')
    step = 255/n;
else
    step = 1.0/n;
end
cell_no = ceil(im/step); % numbers of cells for all pixels
% cell_no can be computed as 0, so we assing them to the first cell
cell_no(cell_no==0) = 1; 


%% Computing the frequencies
%disp('Computing the frequencies...');
% initialization of vector, which will be used for saving the frequencies
freq = zeros(n^3,1); 

% computing to which index belong the data
a = cell_no(:,:,1) - 1;
b = cell_no(:,:,2) - 1;
c = cell_no(:,:,3) - 1;
index = n * a +n^2 *b + c + 1;

% computation of frequencies
for col = 1:size(im, 2)
    for row = 1:size(im, 1)
        freq(index(row,col)) = freq(index(row,col)) + 1;
    end
end
% Reshaping into 3D-array
freq = reshape(freq,n,n,n);

