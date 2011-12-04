% DESCRIPTION
%   A function that extracts the data from the supplied image

% PARAMETERS
%   IN:
%     imin: The input image of the captured QR-code.
%   OUT:
%     strout: The resulting character string of the coded message. 

function strout = getinfo(imin)
    imin(imin<0.5) = 0;
    imin(imin>=0.5) = 1;
    
    %making the fips into gray areas
    imin(1:8,1:8) = 0.5;
    imin(34:41,1:8) = 0.5;
    imin(1:8,34:41) = 0.5;
    imin(33:37,33:37) = 0.5;

    [height, width] = size(imin);
    counter = 1;
    for y = 1 : width
        for x = 1 : height
            if(imin(x,y) ~= 0.5) %if pixel is not gray
                number_vector(counter) = imin(x,y); %then add into vector
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

return