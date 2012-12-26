function test(folder)
clf; % clear all images
files = dir(strcat(folder, '/*.png'));

for i=1:numel(files)    
    % read/show image
    figure(1);
    clf;
    im = imread(strcat(folder, '/', files(i).name));
    imshow(im);
    hold on;
    title(files(i).name)
    
end

hold off;
title('Finished');