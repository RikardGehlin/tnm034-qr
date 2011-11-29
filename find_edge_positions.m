function theAxis = test_edge(theArray, array_size, origin, alongAxis)

% theArray =      [   1 0 0 0 1 0 0 0 0;
%                     1 1 0 0 0 0 1 1 1;
%                     1 1 1 0 1 0 1 0 1;
%                     0 0 0 1 0 1 1 1 1;
%                     1 1 0 1 1 0 0 1 0;
%                     0 1 0 1 0 1 1 0 0
%                 ];
%array_size = size(theArray);

origin = [(origin - array_size(1) * floor((origin-1)/array_size(1))) (floor((origin-1)/array_size(1)) + 1)];

if strcmp(alongAxis, 'vertical')
    px = zeros(3,1);
    py = zeros(3,1);
    nx = zeros(3,1);
    ny = zeros(3,1);
    
    newArray = theArray(1:(origin(1)-1), origin(2));
    newArray = newArray(end:-1:1);
    [y, x] = find(newArray, 3, 'first');
    
    if numel(x)
        for i = 1:numel(x)
            nx(i) = x(i) + origin(2) - 1;
            ny(i) = origin(1) - y(i);
        end
    end

    newArray = theArray((origin(1)+1):end, origin(2));
    [y, x] = find(newArray, 3, 'first');
    
     if numel(x)
        for i = 1:numel(x)
            px(i) = x(i) + origin(2) - 1;
            py(i) = y(i) + origin(1);
        end
    end
   

    theAxis = [origin(1) ny(end:-1:1)' py']';
end 

if strcmp(alongAxis, 'horizontal')
    px = zeros(1,3);
    py = zeros(1,3);
    nx = zeros(1,3);
    ny = zeros(1,3);
    
    newArray = theArray(origin(1), 1:(origin(2)-1));
    newArray = newArray(end:-1:1);
    [y, x] = find(newArray, 3, 'first');

    if numel(x)
        for i = 1:numel(x)
            nx(i) = origin(2) - x(i);
            ny(i) = y(i) + origin(1) - 1;
        end
    end
    

    newArray = theArray(origin(1), (origin(2)+1):end);
    [y, x] = find(newArray, 3, 'first');

    if numel(x)
        for i = 1:numel(x)
            px(i) = x(i) + origin(2);
            py(i) = y(i) + origin(1) - 1;
        end
    end
    


    theAxis = [origin(2) nx(end:-1:1) px]';
end

% position_offset = origin;
% offset_direction = abs(offset_direction);
% 
%     % om x är mindre än max
%     if(position_offset < array_size)
%         %'internal'
%             while(theArray(position_offset(1), position_offset(2)) ~= 1)
%                 position_offset = position_offset + offset_direction;
%                 if(position_offset(1) >= array_size(1) || position_offset(2) >= array_size(2))
%                     %'break2'
%                     break
%                 end
%             end
%         edges = [edges; position_offset];
%         
%         % Den läser inte sista raden... problem? ;)
%         if(position_offset(1) < array_size(1) && position_offset(2) < array_size(2))
%             position_offset = position_offset + offset_direction;
%         end
%     % om vi befinner oss på randen sätt randpositionen som punkt
%     elseif(position_offset(1) == array_size(1) | position_offset(2) == array_size(2))
%         %'edge'
%         edges = [edges; position_offset];
%     % i alla andra fall bryt
%     else
%         %'other'
%     end
% 
% for i = 2 : 3
%     % om x är mindre än max
%     if(position_offset < array_size)
%         %'internal'
%             while(theArray(position_offset(1)-offset_direction(1), position_offset(2)-offset_direction(2)) == 1 || theArray(position_offset(1), position_offset(2)) ~= 1) 
%                 position_offset = position_offset + offset_direction;
%                 if(position_offset(1) >= array_size(1) || position_offset(2) >= array_size(2))
%                     %'break1'
%                     break
%                 end
%             end
%         edges = [edges; position_offset];
%         
%         % Den läser inte sista raden... problem? ;)
%         if(position_offset(1) < array_size(1) && position_offset(2) < array_size(2))
%             position_offset = position_offset + offset_direction;
%         end
%     % om vi befinner oss på randen sätt randpositionen som punkt
%     elseif(position_offset(1) == array_size(1) | position_offset(2) == array_size(2))
%         %'edge'
%         edges = [edges; position_offset];
%     % i alla andra fall bryt
%     else
%         %'other'
%     end
% end

%num_of_edges = size(edges);

% for i = 1 : num_of_edges(1)
%     if(flipY)
%          edges(i,1) = array_size(1) - edges(i,1) + 1;
%     end
% 
%     if(flipX)
%         edges(i,2) = array_size(2) - edges(i,2) + 1;
%     end
% end