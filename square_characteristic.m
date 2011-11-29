% DESCRIPTION
%   A function that finds the PIFS in the supplied image 

% PARAMETERS
%   IN:
%     axis1, axis2: The axes being evaluated 
%   OUT:
%     int: An integer which will be weighted later

function weight = square_characteristic(axis1, axis2)

    weight = (1/4)*(2*abs((abs(axis1(5,:)-axis1(2,:))-abs(axis2(5,:)-axis2(2,:)))/(abs(axis1(5,:)-axis1(2,:))+abs(axis2(5,:)-axis2(2,:)))) + 2*abs((abs(axis1(6,:)-axis1(3,:))-abs(axis2(6,:)-axis2(3,:)))/(abs(axis1(6,:)-axis1(3,:))+abs(axis2(6,:)-axis2(3,:)))) + 2*abs((abs(axis1(7,:)-axis1(4,:))-abs(axis2(7,:)-axis2(4,:)))/(abs(axis1(7,:)-axis1(4,:))+abs(axis2(7,:)-axis2(4,:)))) + 2*abs((abs(axis1(7,:)-axis1(2,:))-abs(axis2(7,:)-axis2(2,:)))/(abs(axis1(7,:)-axis1(2,:))+abs(axis2(7,:)-axis2(2,:)))));

return;