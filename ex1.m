% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function ex1()
close all;
scene1 = imread('../data/xid-2356515_1.jpg');
%scene2 = imread('../data/xid-2356516_1.jpg');
nemo = imread('../data/nemo.jpg');
imshow(scene1);
figure();
imshow(convert(scene1, 'rgb2opponent'));
figure();
imshow(convert(scene1, 'rgb2hsv'));
figure();
imshow(convert(scene1, 'rgb2rgbNormalized'));
%figure();
%backproj = histbackproj(scene1, nemo);
%imshow(backproj)
