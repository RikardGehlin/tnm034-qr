% DESCRIPTION
%   A function that fixes the rotation of the image

% PARAMETERS
%   IN:
%     imin: The input image normalized between 0 and 1
%     corner, right, bottom: coordinates for respective PIF
%   OUT:
%     imout: The resulting image, aligned to the axises

function imout = crop(imin, corner, right, bottom)   
    vector_corner_to_right = right - corner; %hörn till höger
    vector_corner_to_bottom = bottom - corner; % hörn till ned
    %image2
    %imout = imcrop(imin,[corner(2)-(vector_corner_to_right(2)*0.1) corner(1)-(vector_corner_to_bottom(1)*0.09) vector_corner_to_right(2)+(vector_corner_to_right(2)*0.2) vector_corner_to_bottom(1)+(vector_corner_to_bottom(1)*0.2)]);
    %image4
    imout = imcrop(imin,[corner(2)-(vector_corner_to_right(2)*0.09) corner(1)-(vector_corner_to_bottom(1)*0.09) vector_corner_to_right(2)+(vector_corner_to_right(2)*0.2) vector_corner_to_bottom(1)+(vector_corner_to_bottom(1)*0.2)]); %[xstart ystart width height].
    %image3
    %imout = imcrop(imin,[corner(2)-(vector_corner_to_right(2)*0.09) corner(1)-(vector_corner_to_bottom(1)*0.09) vector_corner_to_right(2)+(vector_corner_to_right(2)*0.19) vector_corner_to_bottom(1)+(vector_corner_to_bottom(1)*0.19)]); %[xstart ystart width height].
return;