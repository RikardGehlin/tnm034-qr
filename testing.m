function strout = testing()
image = imread('images/Bygg_4.png'); % reads the given image
double_image = im2double(image); % turning the pixel-values into double-values
normalized_image = double_image / max(double_image(:)); % normalizes between 0 and 1
normalized_image(normalized_image < 0.5) = 0;
normalized_image(normalized_image >= 0.5) = 1;

    %bild_4
    corner = [220 158]; %hörnet
    right = [246 494]; %längst åt höger
    bottom = [558 132]; %längst ned
    %bild_2
    %corner = [222 82]; %hörnet
    %right = [172 466]; %längst åt höger
    %bottom = [604 130]; %längst ned
    %bild_3
    %corner = [236 86]; %hörnet
    %right = [242 460]; %längst åt höger
    %bottom = [612 80]; %längst ned
%corner = [38 38]; %hörnet
 %   right = [38 4]; %längst åt höger
 %   bottom = [4 38]; %längst ned

[rotated_image, new_corner, new_right, new_bottom] = rotation(normalized_image, corner, right, bottom);
cropped = crop(rotated_image, new_corner, new_right, new_bottom);
scaled = scale(cropped);
getinfo(scaled)