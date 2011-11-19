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

<<<<<<< HEAD
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

filtrering = gauss.*shiftad; %Gör så att du filtrerar originalbilden med lp-filtret
x = ifftshift(filtrering); %skiftar tillbaka det
resultat = ifft2(x); %transformerar tillbaka till spatialdomänen
imshow(resultat);

extra = normalized_image - resultat; % bara kontroll vad det är vi har gjort!
figure(2);
imshow(extra);

sharp = normalized_image + B.*(normalized_image - resultat); %skärpning = bild + kantlinjer
figure(3);
imshow(sharp);
figure(4);
imshow(normalized_image);

%filtrering = gauss.*shiftad; %Gör så att du filtrerar originalbilden med lp-filtret
%x = ifftshift(filtrering); %skiftar tillbaka det
%resultat = ifft2(x); %transformerar tillbaka till spatialdomänen
%figure(3);
%imshow(resultat);
%for x = 1 : width
 %   for y = 1 : height
  %     if(normalized_clean_image(y,x) <= 0.5) %mät ut punkter, sätt in i respektive vektor
   %        normalized_clean_image(y,x) = 0;
    %   else
     %      normalized_clean_image(y,x) = 1;
      % end
       
=======
[width, height] = size(normalized_image);

% pre-allocate variables to speed up the program
T = zeros([width,height]);
P = zeros([width,height]);
Q = zeros([width,height]);
B = zeros([width,height]);

for x = 1 : width
    for y = 1 : height
        %gaussian highpass-filter för att ta fram kanter s.184 i BoB-boken
        % distance function från s.167 i BoB-boken
        distance[x,y] = ((x-(width/2))^2 + (y-(height/2))^2)^(1/2);
        gauss_filter[x,y] = 1 - exp(-gauss[x,y]^2/(2*gauss[0,0]^2)); 
        
        if(normalized_image(x,y) < 0.5) %mät ut punkter, sätt in i respektive vektor
>>>>>>> d435e01b61e0bc1e437eb20da7691317e0566247
        %x_axis = 7 värden ifrån (x,y) i x-led där x[0]= (x,y)
   %     x_axis[0] = clean_image(y,x);
        %y_axis = 7 värden ifrån (x,y) i y-led
    %    y_axis[0] = clean_image(y,x);
        %r_axis = 7 värden ifrån (x,y) i r-led
        %x_axis[0] = normalized_image(x,y);
        %s_axis = 7 värden ifrån (x,y) i s-led
<<<<<<< HEAD
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
=======
        T(x,y) = ( central_symmetry(x_axis) + central_symmetry(y_axis) + central_symmetry(r_axis) + central_symmetry(s_axis) )/4;
        P(x,y) = ( ratio_characteristic(x_axis) + ratio_characteristic(y_axis) + ratio_characteristic(r_axis) + ratio_characteristic(s_axis) )/4;
        Q(x,y) = ( square_characteristic(x_axis,y_axis) + square_characteristic(r_axis, s_axis) )/2;
        B(x,y) = ( T[x,y] + P[x,y] + Q[x,y] )/3;
        end
    end
end
>>>>>>> d435e01b61e0bc1e437eb20da7691317e0566247
%localization(normalized_image);

%noise(normalized_image); % calls a function to remove all the noise in the picture

%imshow(normalized_image);
%text = getinfo(img);

%strout=char(text); % the output
return;