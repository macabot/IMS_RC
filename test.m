function test(folder, groundTruth)
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
    
    % draw match 
    location = groundTruth(:,i);
    xCentre = location(2);
    yCentre = location(1);
    
    plot(yCentre, xCentre, 'x', 'MarkerSize', 10, 'LineWidth', 3);
    
end

hold off;
title('Finished');