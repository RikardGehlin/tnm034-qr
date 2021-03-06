% DESCRIPTION
%   A function that fixes the rotation of the image

% PARAMETERS
%   IN:
%     imin: The input image normalized between 0 and 1
%     corner, right, bottom: coordinates for respective PIF
%   OUT:
%     imout: The resulting image, aligned to the axises

function imout = crop(imin, corner, right, bottom)
    vector_corner_to_right = right - corner; %h�rn till h�ger
    vector_corner_to_bottom = bottom - corner; % h�rn till ned
    imout = imcrop(imin,[corner(2)-(vector_corner_to_right(2)*0.1) corner(1)-(vector_corner_to_bottom(1)*0.1) vector_corner_to_right(2)+(vector_corner_to_right(2)*0.2) vector_corner_to_bottom(1)+(vector_corner_to_bottom(1)*0.2)]);
return;