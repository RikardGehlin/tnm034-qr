%inladdning av bilder
fl = im2double(imread('Bilder/photometric_correction_100.jpg'));
fh = im2double(imread('Bilder/photometric_correction_500.jpg'));
correctionbild = im2double(imread('Bilder/geometric_correction.jpg'));

%skapa medelv�rdet s� att vi vet vilka siffror vi f�r
ml = mean(mean(fl));
mh = mean(mean(fh));

%utr�kningar fr�n medelv�rde
p = (mh - ml) ./(fh - fl);
q = ml - (p .* fl);

%bild som skall korrigeras
corrected = (p .* correctionbild) + q;
imwrite (corrected, 'Bilder/Corrected1.jpg', 'jpg');