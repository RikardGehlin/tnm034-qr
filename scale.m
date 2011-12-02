% DESCRIPTION
%   A function that scales the image to 41*41
% PARAMETERS
%   IN:
%     imin: The qr-code in fullsize
%   OUT:
%     imout: The qr-code at 41*41

function imout = noise(imin)
    image = imread(imin); %read the submitted image
    double_image = im2double(image); % turning the pixel-values into double-values
    normalized_image = double_image / max(double_image(:)); % normalizes between 0 and 1
    normalized_image = normalized_image(:,:,1); %only need to calculate in one dimension, since black/white
    
    B = imresize(normalized_image, [41 41]);
    
    imshow(B)
    
return;