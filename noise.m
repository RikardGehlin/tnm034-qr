% DESCRIPTION
%   A function that removes noise from the supplied image

% PARAMETERS
%   IN:
%     imin: The input image normalized between 0 and 1
%   OUT:
%     imout: The resulting image, free of noise

function imout = noise(imin)
    Laplacefilter = [0 1 0; 1 -4 1; 0 1 0];

    bild = imread(imin);
    NormBild = im2double(bild);

    resultat = filter2(Laplacefilter, NormBild,'same');
    imshow(resultat)
   
    imout = NormBild-resultat;
    figure
    imshow(imout)
return