function strout = testing()
image = imread('images/Bygg_4.png'); % reads the given image
double_image = im2double(image); % turning the pixel-values into double-values
normalized_image = double_image / max(double_image(:)); % normalizes between 0 and 1
normalized_image(normalized_image < 0.5) = 0;
normalized_image(normalized_image >= 0.5) = 1;

    %bild_4
    corner = [220 158]; %h�rnet
    right = [246 494]; %l�ngst �t h�ger
    bottom = [558 132]; %l�ngst ned
    %bild_2
    %corner = [222 82]; %h�rnet
    %right = [172 466]; %l�ngst �t h�ger
    %bottom = [604 130]; %l�ngst ned
    %bild_3
    %corner = [236 86]; %h�rnet
    %right = [242 460]; %l�ngst �t h�ger
    %bottom = [612 80]; %l�ngst ned
%corner = [38 38]; %h�rnet
 %   right = [38 4]; %l�ngst �t h�ger
 %   bottom = [4 38]; %l�ngst ned

[rotated_image, new_corner, new_right, new_bottom] = rotation(normalized_image, corner, right, bottom);
cropped = crop(rotated_image, new_corner, new_right, new_bottom);
scaled = scale(cropped);
getinfo(scaled)