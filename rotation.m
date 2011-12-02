% DESCRIPTION
%   A function that fixes the rotation of the image

% PARAMETERS
%   IN:
%     imin: The input image normalized between 0 and 1
%     corner, right, bottom: coordinates for respective PIF
%   OUT:
%     imout: The resulting image, aligned to the axises

function imout = noise(imin, corner, right, bottom)
    image = imread(imin);
    %bild_4
    corner = [224 162] %h�rnet
    right = [250 496] %l�ngst �t h�ger
    bottom = [560 140] %l�ngst ned
    %bild_2
   % P1 = [580 520] %h�rnet
   % P2 = [630 135] %l�ngst �t h�ger
    %P3 = [200 475] %l�ngst ned
    %vector_corner_to_right = right - corner; %h�rn till h�ger
    %vector_corner_to_bottom = bottom - corner; % h�rn till ned
    vector_bottom_to_right = right - bottom % ned till h�ger
    vector_imaginary = [bottom(1), right(2)]
    DP = dot(vector_corner_to_right, vector_imaginary);
    magvector1 = norm(vector_corner_to_right); 
    magvector2 = norm(vector_imaginary);
    radian = acos(DP/(magvector1*magvector2));
    angle = radian*(180/pi)
    correction = 45-angle
    if(P1(1) > P2(1))
        imout = imrotate(image,correction-120);
    else
        imout = imrotate(image,correction);
    end
    imshow(B);
return;