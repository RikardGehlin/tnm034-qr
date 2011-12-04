function strout = tnm034(imin)
% DESCRIPTION
%   A function that removes noise from the supplied image

% PARAMETERS
%   IN:
%     imin: The input image of the captured QR-code.
%   OUT:
%     strout: The resulting character string of the coded message. 
%     The string must be in a pre-defined format given in the course description.

tic
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
        
        x_axis = ones(7,numel(elements));
        y_axis = ones(7,numel(elements));
        
        black_points = find(normalized_image == 0);
        
        edges = find(im_edges == 1);
        
        ratio = [1 1 3 1 1];

        
        points = zeros(1,(numel(edges)-5));

        for i = 1:(numel(edges)-5)
            
            vec = edges(i:(i+5));
            dv = diff(vec);
            result = ( dv'/norm(dv') ) / ( ratio/norm(ratio) );
            
            if result > .95
                points(i) = vec(1) + round((vec(6) - vec(1))/2);
            end
            
        end
        
        points = points(points>0);
       
%'find vectors'        
        
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
        
%'calculate weighting'
        for i = 1:numel(black_points)
            T(black_points(i)) = ( central_symmetry(x_axis(:,black_points(i))) + central_symmetry(y_axis(:,black_points(i))) + central_symmetry(r_axis(:,black_points(i))) + central_symmetry(s_axis(:,black_points(i))) )/4;
            P(black_points(i)) = ( ratio_characteristic(x_axis(:,black_points(i))) + ratio_characteristic(y_axis(:,black_points(i))) + ratio_characteristic(r_axis(:,black_points(i))) + ratio_characteristic(s_axis(:,black_points(i))) )/4;
            Q(black_points(i)) = ( square_characteristic(x_axis(:,black_points(i)),y_axis(:,black_points(i))) + square_characteristic(r_axis(:,black_points(i)), s_axis(:,black_points(i))) )/2;
        end
        
        B = ( T + P + Q )/3;
        B = vec2mat(B,height);

%'calculate FIP coordinates'
        [b,ix] = sort(B(:),'ascend');
        [x y] = ind2sub(size(B), ix(1:12));


% REGION GROWING
%'region growing'
number_of_regions = 0;
counter = 1;
im_segmented = zeros(height, width);

while number_of_regions < 3
    region_size = 1;
    ncoord_pos = 0;
    ncoord_elem = 20;
    ncoord_list = zeros(ncoord_elem, 2);

    sy = y(counter);
    sx = x(counter);


    while region_size < numel(im_edges)
        % get seed point

        % grow seed point until it has reached the edges of the im_edges with a
        % 4-connective algorithm

        neighbors = [-1 0; 1 0; 0 -1; 0 1];
        for i = 1:4
            xn = sx + neighbors(i, 2);
            yn = sy + neighbors(i, 1);

            inside_image = (xn >= 1) && (yn >= 1) && (xn <= width) && (yn <= height);

            if(inside_image && (im_segmented(yn,xn) == 0) && (im_edges(yn,xn) == 0))
                ncoord_pos = ncoord_pos + 1;
                ncoord_list(ncoord_pos,:) = [yn xn];
                im_segmented(yn,xn) = 1;
            end
        end

        if((ncoord_pos + 10) > ncoord_elem)
            ncoord_elem = ncoord_elem + 50;
            ncoord_list((ncoord_pos + 1):ncoord_elem,:) = 0;
        end

        if ncoord_pos <= 0
            % Get number of regions in image
            number_of_regions = max(max(bwlabel(im_segmented)));
            break
        end

        sx = ncoord_list(1,2);
        sy = ncoord_list(1,1);

        ncoord_list = ncoord_list(2:end,:);
        ncoord_pos = ncoord_pos - 1;

    end
    counter = counter + 1;
end

im_segmented = bwlabel(im_segmented, 4);

fips = zeros(3,2);

fips(1,:) = cell2mat(struct2cell(regionprops(im_segmented==1, 'Centroid')));
fips(2,:) = cell2mat(struct2cell(regionprops(im_segmented==2, 'Centroid')));
fips(3,:) = cell2mat(struct2cell(regionprops(im_segmented==3, 'Centroid')));

% figure(10)
% imshow(image)
% hold on
% plot(fips(1,1),fips(1,2),'r+');
% plot(fips(2,1),fips(2,2),'g+');
% plot(fips(3,1),fips(3,2),'b+');
% hold off

% for image2
corner = round(fips(2,end:-1:1));
bottom = round(fips(1,end:-1:1));
right = round(fips(3,end:-1:1));


[rotated_image, new_corner, new_right, new_bottom] = rotation(normalized_image, corner, right, bottom);
figure(3)
imshow(rotated_image)

cropped = crop(rotated_image, new_corner, new_right, new_bottom);
figure(4)
imshow(cropped)
scaled = scale(cropped);
figure(5)
imshow(scaled)
strout = getinfo(scaled)
toc
return