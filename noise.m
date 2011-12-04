% DESCRIPTION
%   A function that removes noise from the supplied image

% PARAMETERS
%   IN:
%     imin: The input image normalized between 0 and 1
%   OUT:
%     imout: The resulting image, free of noise

function imout = noise(imin)
    Laplacefilter = [0 1 0; 1 -4 1; 0 1 0];
    resultat = filter2(Laplacefilter, imin,'same');
    imout = imin-resultat;
return