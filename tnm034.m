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

[height, width] = size(normalized_image);

% Hård tröskling... ändra?
normalized_image(normalized_image<0.5) = 0;
normalized_image(normalized_image>=0.5) = 1;

im_edges = edge_detection(normalized_image);

% Hård tröskling... OK?
im_edges(im_edges<0.05) = 0;
im_edges(im_edges>=0.05) = 1;

% pre-allocate variables to speed up the program
T = zeros(height, width);
P = zeros(height, width);
Q = zeros(height, width);
B = zeros(height, width);


% Testning av hur man bygger "axlarna"
%tjena = [[400 300]; flipdim(find_edge_positions(im_edges, [400 300], [0 -1]), 1); find_edge_positions(im_edges, [400 300], [0 1])];
%tjena(:,2)

elements = 1:numel(im_edges);
strout = im_edges;
return
        % x_axis = 7 värden ifrån (y,x) i x-led där x[0]= (y,x)
'find vectors'
tic
x_axis = arrayfun(@(x) find_edge_positions(im_edges, [height, width], x, 'horizontal'), elements, 'UniformOutput', false);
x_axis = cell2mat(x_axis);
y_axis = arrayfun(@(x) find_edge_positions(im_edges, [height, width], x, 'vertical'), elements, 'UniformOutput', false);
y_axis = cell2mat(y_axis);
%find_edge_positions(im_edges, [height, width], 104236, 'horizontal')
toc
        
        % use x- and y-axis as r- and s- axis temporarily
        r_axis = x_axis;
        s_axis = y_axis;
        % r_axis = 7 värden ifrån (y,x) i r-led
        % s_axis = 7 värden ifrån (y,x) i s-led
        
'calculate weighting'
        T = ( central_symmetry(x_axis) + central_symmetry(y_axis) + central_symmetry(r_axis) + central_symmetry(s_axis) )/4;
        P = ( ratio_characteristic(x_axis) + ratio_characteristic(y_axis) + ratio_characteristic(r_axis) + ratio_characteristic(s_axis) )/4;
        Q = ( square_characteristic(x_axis,y_axis) + square_characteristic(r_axis, s_axis) )/2;
        B = ( T + P + Q )/3;
        B(isnan(B)) = 1;
        B = vec2mat(B,height);
strout = B';

%localization(normalized_image);

%noise(normalized_image); % calls a function to remove all the noise in the picture

%imshow(normalized_image);
%text = getinfo(img);

%strout=char(text); % the output
return;