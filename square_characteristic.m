% DESCRIPTION
%   A function that finds the PIFS in the supplied image 

% PARAMETERS
%   IN:
%     o: The pixel currently being evaluated.
%     axis1, axis2: The axes being evaluated 
%   OUT:
%     int: An integer which will be weighted later

function int = square_characteristic(o, axis1, axis2)

int = (1/4)*(2*abs((abs(axis1[4]-axis1[1])-abs(axis2[4]-axis2[1]))/(abs(axis1[4]-axis1[1])+abs(axis2[4]-axis2[1]))) + 2*abs((abs(axis1[5]-axis1[2])-abs(axis2[5]-axis2[2]))/(abs(axis1[5]-axis1[2])+abs(axis2[5]-axis2[2]))) + 2*abs((abs(axis1[6]-axis1[3])-abs(axis2[6]-axis2[3]))/(abs(axis1[6]-axis1[3])+abs(axis2[6]-axis2[3]))) + 2*abs((abs(axis1[6]-axis1[1])-abs(axis2[6]-axis2[1]))/(abs(axis1[6]-axis1[1])+abs(axis2[6]-axis2[1]))));

return;