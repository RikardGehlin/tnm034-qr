% DESCRIPTION
%   A function that scales the image to 41*41
% PARAMETERS
%   IN:
%     imin: The qr-code in fullsize
%   OUT:
%     imout: The qr-code at 41*41

function imout = scale(imin)
    imout = imresize(imin, [41 41]);
return;