function strout = tnm034(imin)
% DESCRIPTION
%   A function that removes noise from the supplied image

% PARAMETERS
%   IN:
%     imin: The input image of the captured QR-code.
%   OUT:
%     strout: The resulting character string of the coded message. 
%     The string must be in a pre-defined format given in the course description.

image = imread(imin); % reads the given image
double_image = im2double(image); % turning the pixel-values into double-values
normalized_image = double_image / max(double_image(:)); % normalizes between 0 and 1

[height, width] = size(normalized_image);





% gaussian highpass-filter f�r att ta fram kanter s.184 i BoB-boken
% distance function fr�n s.167 i BoB-boken
distance(y,x) = ((x-(width/2))^2 + (y-(height/2))^2)^(1/2);
gauss_filter(y,x) = 1 - exp(-gauss(y,x)^2/(2*gauss(0,0)^2)); 



% pre-allocate variables to speed up the program
T = zeros(height, width);
P = zeros(height, width);
Q = zeros(height, width);
B = zeros(height, width);

for x = 1 : width
    for y = 1 : height
        
        if(normalized_image(y,x) < 0.5) %m�t ut punkter, s�tt in i respektive vektor
        % x_axis = 7 v�rden ifr�n (y,x) i x-led d�r x[0]= (y,x)
        
        % y_axis = 7 v�rden ifr�n (y,x) i y-led
        % r_axis = 7 v�rden ifr�n (y,x) i r-led
        % s_axis = 7 v�rden ifr�n (y,x) i s-led
        T(y,x) = ( central_symmetry(x_axis) + central_symmetry(y_axis) + central_symmetry(r_axis) + central_symmetry(s_axis) )/4;
        P(y,x) = ( ratio_characteristic(x_axis) + ratio_characteristic(y_axis) + ratio_characteristic(r_axis) + ratio_characteristic(s_axis) )/4;
        Q(y,x) = ( square_characteristic(x_axis,y_axis) + square_characteristic(r_axis, s_axis) )/2;
        B(y,x) = ( T(y,x) + P(y,x) + Q(y,x) )/3;
        end
    end
end
%localization(normalized_image);

%noise(normalized_image); % calls a function to remove all the noise in the picture

%imshow(normalized_image);
%text = getinfo(img);

%strout=char(text); % the output
return;