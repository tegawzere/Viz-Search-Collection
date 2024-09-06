
% function F=EdgeOriHistogram_extractRandom(img)
% %hard code the size of the grid in this just like for quantization 
% %bins for histogram
% %image rows and columns 
% %separating the img by img(x,y,colour); if not yyou get inaccurate values
% Grid_size_rows = 6;
% Grid_size_columns = 6; 
% grayscale_img = rgb2gray(img);
% 
% %image rows and columns 
% %separating the img by img(x,y,colour); if not yyou get inaccurate values
% image_Rows = size(img(:,1,1));
% image_Columns = size(img(1,:,1));
% 
% %extracting the actual variables for the size of the image from the
% %variables from the 1 x 2 matrices
% rows = image_Rows(:,1);
% columns = image_Columns(:,2);
% 
% %horizontal derivatives
% sobel_filter_x = [1 0 -1; 2 0 -2; 1 0 -1;]./4;
% %vertical derivatves
% sobel_filter_y = [1 2 1; 0 0 0; -1 -2 -1;]./4;
% 
% 
% img_horizontal_edges = conv2(grayscale_img, sobel_filter_y,'same');
% img_vertical_edges = conv2(grayscale_img,sobel_filter_x,'same');
% % rows
% % columns
% 
% %calculates the size of the cells in the grid 
% Grid_pixel_rows = floor(rows / Grid_size_rows);
% Grid_pixel_columns = floor(columns / Grid_size_columns);
% 
% % imageRow
% % imageColumn 
% 
% combined_colours = [];
% 
% % testingerror
% rowposition = 0;
% columnposition = 0;
% 
% Q = 5;
% 
% 
% 
% 
% 
% vertical_edges = atan(sobel_filter_x);
% horizontal_edges = atan(sobel_filter_y);
% 
% %use the argument same to ensure that output is same size as input 
% % img_horizontal_edges = conv2(img, sobel_filter_y,'same');
% % img_vertical_edges = conv2(img,sobel_filter_x,'same');
% 
% %gradients direction
% image_direction = atan2d(img_horizontal_edges,img_vertical_edges);
% 
% %magnitude calculation 
% magnitude_img = sqrt((img_horizontal_edges.^2)+(img_vertical_edges.^2));
% 
% % edges = linspace(-180,180, Q+1);
% 
% %as shown in the slides the orientation is normally quantised into 8 bins 
% %while we only get the strong edges so we subtract any we edge from 2 pi??
% for i=1 : rows
%     if (image_direction(i,j) < 0)
%         image_direction = 2 * pi - abs(image_direction);
%     end
% end
% 
% %array for histogram 
% histogram_array = zeros(1, Q);
% 
% 
% 
% 
% 
% 
% 
% for i=1 : Grid_pixel_rows : rows
%     if (rowposition ~= Grid_size_rows)
%     for j=1 : Grid_pixel_columns : columns
%         if (columnposition ~= Grid_size_columns)
%             % top = (i - 1) * imagerows + 1;
%             % bottom = i * imagerows;
%             % left = (j - 1) * imagecolumns + 1;
%             % right = j * imagecolumns;
%             top = i;
%             bottom = top + Grid_pixel_rows - 1;
%             left = j;
%             right = j + Grid_pixel_columns - 1;
% 
% 
%             if(rowposition == Grid_size_rows - 1)
%                 bottom = rows; 
%             end
% 
%             if(columnposition == Grid_size_columns - 1)
%                 right = columns; 
%             end
% 
%             %am i supposed to do something with pi(2pi)(look at slides)
%             %divide them into 8 bins?
%             %if statement for if the edges are strong? 
%             %probably if the edge angle is over a certain degree
%             %
%             bin = floor(image_direction(i, j) + 180 / 360 * Q) + 1;
%             histogram_array(bin) = histogram_array(bin) + magnitude_img;
% 
%             % testingx = (top:bottom)
%             % testingy = (left:right)
% 
%             % red = img(top:bottom,left:right,1);
%             % red = reshape(red,1,[]);
%             % average_red = mean(red);
%             % 
%             % green = img(top:bottom,left:right,2);
%             % green = reshape(green,1,[]);
%             % average_green = mean(green);
%             % 
%             % blue = img(top:bottom,left:right,3);
%             % blue = reshape(blue,1,[]);
%             % average_blue = mean(blue);
%             % 
%             % combined_colours(end+1) = average_red;
%             % combined_colours(end+1) = average_green;
%             % combined_colours(end+1) = average_blue;
%             % % testing
% 
%             columnposition = columnposition + 1;
%             %check my values are storing
%         end
% 
%      end
%        rowposition = rowposition + 1;
%        columnposition = 0; 
%     end
% end
% histogram_array = histogram_array / sum(histogram_array);
% combined_colors(end + 1); 
% F=combined_colours;
% return;


% %trial 2
% function F = EdgeOriHistogram_extractRandom(img)
% % Set the number of bins for the histogram
% Q = 36;  % You can adjust this to your preference
% 
% % Convert the input image to grayscale
% grayscale_img = rgb2gray(img);
% 
% % Define horizontal and vertical Sobel filters
% sobel_filter_x = [1 0 -1; 2 0 -2; 1 0 -1] / 4;
% sobel_filter_y = [1 2 1; 0 0 0; -1 -2 -1] / 4;
% 
% % Calculate the gradients in both horizontal and vertical directions
% img_horizontal_edges = conv2(grayscale_img, sobel_filter_x, 'same');
% img_vertical_edges = conv2(grayscale_img, sobel_filter_y, 'same');
% 
% % Calculate the magnitude and direction of gradients
% magnitude_img = sqrt(img_horizontal_edges.^2 + img_vertical_edges.^2);
% direction_img = atan2d(img_vertical_edges, img_horizontal_edges);  % Use degrees
% 
% % Define the histogram bins and their edges
% edges = linspace(-180, 180, Q + 1);  % Create Q bins from -180 to 180 degrees
% 
% % Initialize an array to store the histogram values
% histogram = zeros(1, Q);
% 
% % Loop through the entire image and accumulate gradient direction into bins
% for i = 1:size(grayscale_img, 1)
%     for j = 1:size(grayscale_img, 2)
%         bin = floor((direction_img(i, j) + 180) / 360 * Q) + 1;
%         histogram(bin) = histogram(bin) + magnitude_img(i, j);
%     end
% end
% 
% F = histogram;


% %trial 3 - this works
% 
function F = EdgeOriHistogram_extractRandom(img)
% Set the number of bins for the histogram
Q = 128;

% Convert the input image to grayscale
grayscale_img = rgb2gray(img);

% Define horizontal and vertical Sobel filters
sobel_filter_x = [1 0 -1; 2 0 -2; 1 0 -1] ./ 4;
sobel_filter_y = [1 2 1; 0 0 0; -1 -2 -1] ./ 4;

% Calculate the gradients in both horizontal and vertical directions
img_horizontal_edges = conv2(grayscale_img, sobel_filter_x, 'same');
img_vertical_edges = conv2(grayscale_img, sobel_filter_y, 'same');

% Calculate the magnitude and direction of gradients
magnitude_img = sqrt(img_horizontal_edges.^2 + img_vertical_edges.^2);
direction_img = atan2d(img_vertical_edges, img_horizontal_edges);  % Use degrees

% Define the histogram bins and their edges
edges = linspace(-180, 180, Q + 1);  % Create Q bins from -180 to 180 degrees

% Initialize an array to store the histogram values
histogram = zeros(1, Q);

% Loop through the entire image and accumulate gradient direction into bins
for i = 1:size(grayscale_img, 1)
    for j = 1:size(grayscale_img, 2)
        bin = floor((direction_img(i, j) + 180) / 360 * Q) + 1;
        if bin >= 1 && bin <= Q  % Ensure that the bin is within the valid range
            histogram(bin) = histogram(bin) + magnitude_img(i, j);
        end
    end
end
% histogram
F = histogram;


return