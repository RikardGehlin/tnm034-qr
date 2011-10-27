function strout = tnm034(imin)
% imin: The input image of the captured QR-code.
% strout: The resulting character string of the coded message. The string must be in a pre-defined format given in the course description.

image = imread(imin); %reads the given image
double_image = im2double(image); %turning the pixel-values into double-values
normalized_image = double_image / max(double_image(:)); %normalizes between 0 and 1

noise(normalized_image); %calls a function to remove all the noise in the picture

imshow(normalized_image);


%strout=char(string); % The output
return;