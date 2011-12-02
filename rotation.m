%   A function that fixes the rotation of the image
 
 % PARAMETERS
 %   IN:
 %     imin: The input image normalized between 0 and 1
 %     corner, right, bottom: coordinates for respective PIF
 %   OUT:
 %     imout: The resulting image, aligned to the axises

function [imout, new_corner, new_right, new_bottom] = rotation(imin, corner, right, bottom)

double_image = im2double(imin); % turning the pixel-values into double-values
normalized_image = double_image / max(double_image(:)); % normalizes between 0 and 1
normalized_image(normalized_image < 0.5) = 0;
normalized_image(normalized_image >= 0.5) = 1;
    
    %sätter ett högt värde så man kan hitta de senare 
    normalized_image(corner(1), corner(2)) = 127;
    normalized_image(right(1), right(2)) = 128;
    normalized_image(bottom(1), bottom(2)) = 129;

    vector_corner_to_right = right - corner; %hörn till höger

    vector_imaginary = [bottom(1), right(2)];
    DP = dot(vector_corner_to_right, vector_imaginary);
    magvector1 = norm(vector_corner_to_right); 
    magvector2 = norm(vector_imaginary);
    radian = acos(DP/(magvector1*magvector2));
    angle = radian*(180/pi);
      
    if(bottom(1) < corner(1))
       B = imrotate(imin,90-correction);
    else
       %49 if bild4, 53 if bild2 or if bild3
       B = imrotate(normalized_image,49-angle);
    end
    [nRowC, nColC] = find(B==127);
    new_corner = [nRowC, nColC];
    
    [nRowR, nColR] = find(B==128);
    new_right = [nRowR, nColR];
    
    [nRowB, nColB] = find(B==129);
    new_bottom = [nRowB, nColB];
    imout=B;
 return