% DESCRIPTION
%   A function that scales the image to 41*41
% PARAMETERS
%   IN:
%     imin: The input image normalized between 0 and 1
%   OUT:
%     imout: The resulting image, centered

function imout = noise(imin)
    image = imread(imin); %read the submitted image
    double_image = im2double(image); % turning the pixel-values into double-values
    normalized_image = double_image / max(double_image(:)); % normalizes between 0 and 1
    normalized_image = normalized_image(:,:,1); %only need to calculate in one dimension, since black/white
    
    for i=1:41
        for j=1:41
            %här behövs en funktion för att kunna skala om till enskilda
            %pixelvärden
            new_image(i,j) = normalized_image(8,8); 
        end
    end
    
    imshow(new_image)
    
return;