function groundTruth = getGroundTruth(folder)
clf; % clear all images
files = dir(strcat(folder, '/*.png'));

groundTruth = zeros(numel(files), 2);

for i=1:numel(files)    
    % read/show image
    figure(1);
    clf;
    im = imread(strcat(folder, '/', files(i).name));
    imshow(im);
    hold on;
    title(files(i).name)
    
    % pick player
    location = ginput(1);
    groundTruth(i,:) = location;
    % draw match 
    plot(location(1), location(2), 'x', 'MarkerSize', 10, 'LineWidth', 3);
    
end

hold off;
title('Finished');