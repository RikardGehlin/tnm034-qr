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
%        if(normalized_image(x,y) < 0.5)
%            normalized_image(x,y) = 0;
%        else
%            normalized_image(x,y) = 1;
%        end


%gaussian highpass-filter f�r att ta fram kanter
if(normalized_image(x,y) < 0,5)
    %m�t ut punkter, s�tt in i respektive vektor
    
%x_axis = 7 v�rden ifr�n (x,y) i x-led d�r x[0]= (x,y)
%y_axis = 7 v�rden ifr�n (x,y) i y-led
%r_axis = 7 v�rden ifr�n (x,y) i r-led
%s_axis = 7 v�rden ifr�n (x,y) i s-led
        T[x,y] = ( central_symmetry(x_axis) + central_symmetry(y_axis) + central_symmetry(r_axis) + central_symmetry(s_axis) )/4;
        P[x,y] = ( ratio_characteristic(x_axis) + ratio_characteristic(y_axis) + ratio_characteristic(r_axis) + ratio_characteristic(s_axis) )/4;
        Q[x,y] = ( square_characteristic(x_axis,y_axis) + square_characteristic(r_axis, s_axis) )/2;
        B[x,y] = ( T[x,y] + P[x,y] + Q[x,y] )/3;
    end
end
%localization(normalized_image);

%noise(normalized_image); % calls a function to remove all the noise in the picture

%imshow(normalized_image);
%text = getinfo(img);

%strout=char(text); % the output
return;