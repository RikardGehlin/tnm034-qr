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

% pre-allocate variables to speed up the program
T = zeros(height,width);
P = zeros(height,width);
Q = zeros(height,width);
B = zeros(height,width);

A = 0.15;
sigma = 20;

new = filter2(1-fspecial('gaussian'), normalized_image, 'same');
figure(18);
imshow(new);

fourierbild = fft2(new);
shiftad = fftshift(fourierbild);
[r, c] = size(shiftad);
[u, v] = meshgrid(-(c/2)+1:1:c/2, -(r/2)+1:1:r/2);
gauss = exp(-((u.^2+v.^2)/(2*sigma^2)));

filtrering = gauss.*shiftad; %G�r s� att du filtrerar originalbilden med lp-filtret
x = ifftshift(filtrering); %skiftar tillbaka det
resultat = ifft2(x); %transformerar tillbaka till spatialdom�nen
imshow(resultat);

extra = normalized_image - resultat; % bara kontroll vad det �r vi har gjort!
figure(2);
imshow(extra);

sharp = normalized_image + B.*(normalized_image - resultat); %sk�rpning = bild + kantlinjer
figure(3);
imshow(sharp);
figure(4);
imshow(normalized_image);

%filtrering = gauss.*shiftad; %G�r s� att du filtrerar originalbilden med lp-filtret
%x = ifftshift(filtrering); %skiftar tillbaka det
%resultat = ifft2(x); %transformerar tillbaka till spatialdom�nen
%figure(3);
%imshow(resultat);
%for x = 1 : width
 %   for y = 1 : height
  %     if(normalized_clean_image(y,x) <= 0.5) %m�t ut punkter, s�tt in i respektive vektor
   %        normalized_clean_image(y,x) = 0;
    %   else
     %      normalized_clean_image(y,x) = 1;
      % end
       
        %x_axis = 7 v�rden ifr�n (x,y) i x-led d�r x[0]= (x,y)
   %     x_axis[0] = clean_image(y,x);
        %y_axis = 7 v�rden ifr�n (x,y) i y-led
    %    y_axis[0] = clean_image(y,x);
        %r_axis = 7 v�rden ifr�n (x,y) i r-led
        %x_axis[0] = normalized_image(x,y);
        %s_axis = 7 v�rden ifr�n (x,y) i s-led
        %x_axis[0] = normalized_image(x,y);
     %   T(y,x) = ( central_symmetry(x_axis) + central_symmetry(y_axis) + central_symmetry(r_axis) + central_symmetry(s_axis) )/4;
      %  P(y,x) = ( ratio_characteristic(x_axis) + ratio_characteristic(y_axis) + ratio_characteristic(r_axis) + ratio_characteristic(s_axis) )/4;
       % Q(y,x) = ( square_characteristic(x_axis,y_axis) + square_characteristic(r_axis, s_axis) )/2;
        %B(y,x) = ( T[y,x] + P[y,x] + Q[y,x] )/3;
      %  end
   % end
%end
%figure(4);
 %      imshow(normalized_clean_image);
%localization(normalized_image);

%noise(normalized_image); % calls a function to remove all the noise in the picture

%imshow(normalized_image);
%text = getinfo(img);

%strout=char(text); % the output
return;