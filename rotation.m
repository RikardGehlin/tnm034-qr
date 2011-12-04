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

    fip_vec = right - corner; %hörn till höger
    ref_vec = [0, 1];
     
    CosTheta = dot(fip_vec,ref_vec)/(norm(fip_vec)*norm(ref_vec));
    angle = acos(CosTheta)*180/pi;
    
    if(fip_vec(1) < 0)
        B = imrotate(normalized_image, -angle);
    else
        B = imrotate(normalized_image, angle);
    end

    [nRowC, nColC] = find(B==127);
    new_corner = [nRowC(1), nColC(1)];
    
    [nRowR, nColR] = find(B==128);
    new_right = [nRowR(1), nColR(1)];
    
    [nRowB, nColB] = find(B==129);
    new_bottom = [nRowB(1), nColB(1)];
    
    imout=B;
 return