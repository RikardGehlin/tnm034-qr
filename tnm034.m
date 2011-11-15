% DESCRIPTION
%   A function that removes noise from the supplied image

% PARAMETERS
%   IN:
%     imin: The input image of the captured QR-code.
%   OUT:
%     strout: The resulting character string of the coded message. 
%     The string must be in a pre-defined format given in the course description.

function strout = tnm034(imin)

image = imread(imin); % reads the given image
double_image = im2double(image); % turning the pixel-values into double-values
normalized_image = double_image / max(double_image(:)); % normalizes between 0 and 1

%to make the image black/white
[width, height] = size(normalized_image);
for x = 1 : width
    for y = 1 : height
        if(normalized_image(x,y) < 0.5)
            normalized_image(x,y) = 0;
        else
            normalized_image(x,y) = 1;
        end
    end
end
imshow(normalized_image)
%noise(normalized_image); % calls a function to remove all the noise in the picture

%imshow(normalized_image);
text = getinfo(img);

%strout=char(text); % the output
return;