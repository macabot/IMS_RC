function [ output_args ] = avi2png( filename )
obj = mmreader(filename);
vid = read(obj);
frames = obj.NumberOfFrames;
for x = 1 : frames
    imwrite(vid(:,:,:,x),strcat('frame-',sprintf('%03d\n',x),'.png'));
end
end

