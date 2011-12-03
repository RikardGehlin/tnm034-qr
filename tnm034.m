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

if isrgb(image)
    image = rgb2gray(image);
end

double_image = im2double(image); % turning the pixel-values into double-values
normalized_image = double_image / max(double_image(:)); % normalizes between 0 and 1

[height, width] = size(normalized_image);
%noise(normalized_image); % calls a function to remove all the noise in the
%picture
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
im_edges = bwmorph(im_edges, 'skel', Inf);



elements = 1:numel(im_edges);
        % x_axis = 7 värden ifrån (y,x) i x-led där x[0]= (y,x)
        
        x_axis = ones(7,numel(elements));
        y_axis = ones(7,numel(elements));
        
        black_points = find(normalized_image == 0);
        %x_axis(:,black_points)
        
        edges = find(im_edges == 1);
        
        tic
        ratio = [1 1 3 1 1];
'before1'
        
        points = zeros(1,(numel(edges)-5));
'before2'
        for i = 1:(numel(edges)-5)
            
            vec = edges(i:(i+5));
            dv = diff(vec);
            result = ( dv'/norm(dv') ) / ( ratio/norm(ratio) );
            
            if result > .95
                points(i) = vec(1) + round((vec(6) - vec(1))/2);
            end
            
        end
        
        points = points(points>0);
       toc
'find vectors'        
        
        T = ones(1,numel(elements));
        P = ones(1,numel(elements));
        Q = ones(1,numel(elements));
        black_points = points;
        for i = 1:numel(black_points)
            origin = [(black_points(i) - height * floor((black_points(i)-1)/height)) (floor((black_points(i)-1)/height) + 1)];
            x_axis(:,black_points(i)) = find_edge_positions(im_edges, [height, width], origin, 'horizontal');
            y_axis(:,black_points(i)) = find_edge_positions(im_edges, [height, width], origin, 'vertical');
        end
                
        % use x- and y-axis as r- and s- axis temporarily
        r_axis = x_axis;
        s_axis = y_axis;
        % r_axis = 7 värden ifrån (y,x) i r-led
        % s_axis = 7 värden ifrån (y,x) i s-led
        
'calculate weighting'
        for i = 1:numel(black_points)
            T(black_points(i)) = ( central_symmetry(x_axis(:,black_points(i))) + central_symmetry(y_axis(:,black_points(i))) + central_symmetry(r_axis(:,black_points(i))) + central_symmetry(s_axis(:,black_points(i))) )/4;
            P(black_points(i)) = ( ratio_characteristic(x_axis(:,black_points(i))) + ratio_characteristic(y_axis(:,black_points(i))) + ratio_characteristic(r_axis(:,black_points(i))) + ratio_characteristic(s_axis(:,black_points(i))) )/4;
            Q(black_points(i)) = ( square_characteristic(x_axis(:,black_points(i)),y_axis(:,black_points(i))) + square_characteristic(r_axis(:,black_points(i)), s_axis(:,black_points(i))) )/2;
        end
toc


        

%         T = ( central_symmetry(x_axis) + central_symmetry(y_axis) + central_symmetry(r_axis) + central_symmetry(s_axis) )/4;
%         P = ( ratio_characteristic(x_axis) + ratio_characteristic(y_axis) + ratio_characteristic(r_axis) + ratio_characteristic(s_axis) )/4;
%         Q = ( square_characteristic(x_axis,y_axis) + square_characteristic(r_axis, s_axis) )/2;
        B = ( T + P + Q )/3;
        B(isnan(B)) = 1;
        B = vec2mat(B,height);

        [b,ix] = sort(B(:),'ascend');
        [x y] = ind2sub(size(B), ix(1:12))
        imshow(image);
        hold on;
        plot(x,y,'ro')
        plot(x(4),y(4),'r+');
        plot(x(2),y(2),'b+');
        plot(x(3),y(3),'g+');
        hold off;
toc

%for image2
%bottom = [y(1) x(1)]
%corner = [y(2) x(2)]
%right = [y(3) x(3)]

%for image4
%bottom = [y(1) x(1)]
%corner = [y(2) x(2)]
%right = [y(3) x(3)]

%[rotated_image, new_corner, new_right, new_bottom] = rotation(normalized_image, corner, right, bottom);
%imshow(rotated_image)
%cropped = crop(rotated_image, new_corner, new_right, new_bottom);
%figure
%imshow(cropped)
%scaled = scale(cropped);
%figure
%imshow(scaled)
%getinfo(scaled)
return