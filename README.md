IMS_RC
=======
By Richard Rozeboom (6173292) and Michael Cabot (6047262).

Task:
- create Mean Shift Tracker

Dependencies
=======

- MATLAB http://www.mathworks.nl/products/matlab/

meanShiftTracker.m
=======
Input:
- folder : directory of frames that contain target
- bins : amount of bins for the histogram. Note that there are actually bins^3 bins in the histogram.
- groundTruth : Matrix containing the true locations of the target for each frame.
- player : Name of the target. Possible values: 'upperLeft', 'upperLeft2', 'dreads', 'dreads2', 'referee', 'blue' and ''. If empty string is geven, then upper-left and lower-right corner of target must be picked by hand.
- colorSpace : Color space that the target and frames should be converted to. Possible values: 'rgb2rgbNormalized', 'rgb2opponent', 'rgb2hsv', 'rgb2hue' and ''. If empty string is given, then only im2double/1 is applied.

Output:
- frames : Struct containing images annotated with ground truth (green) and mean shift (blue) location.
- averageDuration : average duration of Mean Shift Tracker.
- error : average distance between ground truth and mean shift location.