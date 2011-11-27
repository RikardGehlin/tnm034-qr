% DESCRIPTION
%   A function that extracts the data from the supplied image

% PARAMETERS
%   IN:
%     imin: The input image of the captured QR-code.
%   OUT:
%     strout: The resulting character string of the coded message. 

function strout = getinfo(imin)
	image = imread(imin); %read the submitted image
    %------------------------------
    %might have been done in previous step!
    double_image = im2double(image); % turning the pixel-values into double-values
    normalized_image = double_image / max(double_image(:)); % normalizes between 0 and 1
    normalized_image = normalized_image(:,:,1); %only need to calculate in one dimension, since black/white
    %-----------------------------
    
    %making the fips into gray areas
    normalized_image(1:8,1:8) = 0.5;
    normalized_image(34:41,1:8) = 0.5;
    normalized_image(1:8,34:41) = 0.5;
    normalized_image(33:37,33:37) = 0.5;
    
    imshow(normalized_image)
    
    [height, width] = size(normalized_image);
    counter = 1;
    for y = 1 : width
        for x = 1 : height
            if(normalized_image(x,y) ~= 0.5) %if pixel is not gray
                number_vector(counter) = normalized_image(x,y); %then add into vector
                counter = counter + 1;
            end
        end
    end
    
    strout = '';
    for z = 1 : length(number_vector(1:end/8)) %go through vector/8 since binary = 8 numbers/letter
        letter_string = num2str(number_vector(1:8)); %select the 8 first and make them into a string
        strout = [strout, char(bin2dec(letter_string))]; %take string, and turn the into letters, add into a new string
        number_vector = number_vector(9:end); %remove the 8 first numbers in vector
    end

return;