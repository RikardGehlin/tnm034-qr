% DESCRIPTION
%   A function that finds the PIFS in the supplied image 

% PARAMETERS
%   IN:
%     axis: The axis being evaluated 
%   OUT:
%     int: An integer which will be weighted later

function weight = ratio_characteristic(axis)
    weight = (1/7)*(abs((axis(5)-axis(1))/(axis(6)-axis(2)) - 1) + abs((axis(4)-axis(1))/(axis(6)-axis(3)) - 1) + abs((axis(3)-axis(1))/(axis(6)-axis(4)) - 1) + abs((axis(5)-axis(3))/(axis(6)-axis(4)) - 1) + abs((axis(4)-axis(2))/(axis(3)-axis(1)) - 1) + abs((axis(3)-axis(2))/(axis(5)-axis(4)) - 1) + abs((axis(2)-axis(1))/(axis(6)-axis(5)) - 1));
return;