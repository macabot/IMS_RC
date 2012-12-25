function playGroundTruth(folder, groundTruth)
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
    
    % pick player
    location = groundTruth(i,:);
    % draw match 
    plot(location(1), location(2), 'x', 'MarkerSize', 10, 'LineWidth', 3);
    
end

hold off;
title('Finished');