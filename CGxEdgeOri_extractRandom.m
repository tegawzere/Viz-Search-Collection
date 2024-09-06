% %trial 3 - this works
% 
function F = CGxEdgeOri_extractRandom(img)
%Spatial Grid stuff
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

%Colour Grid Stuff
Grid_size_rows = 6;
Grid_size_columns = 6; 

%image rows and columns 
%separating the img by img(x,y,colour); if not yyou get inaccurate values
image_Rows = size(img(:,1,1));
image_Columns = size(img(1,:,1));



%extracting the actual variables for the size of the image from the
%variables from the 1 x 2 matrices
rows = image_Rows(:,1);
columns = image_Columns(:,2);

% rows
% columns


%calculates the size of the cells in the grid 
Grid_pixel_rows = floor(rows / Grid_size_rows);
Grid_pixel_columns = floor(columns / Grid_size_columns);


% imageRow
% imageColumn 

combined_colours = [];

% testingerror
rowposition = 0;
columnposition = 0;

for i=1 : Grid_pixel_rows : rows
    if (rowposition ~= Grid_size_rows)
    for j=1 : Grid_pixel_columns : columns
        if (columnposition ~= Grid_size_columns)
            % top = (i - 1) * imagerows + 1;
            % bottom = i * imagerows;
            % left = (j - 1) * imagecolumns + 1;
            % right = j * imagecolumns;
            top = i;
            bottom = top + Grid_pixel_rows - 1;
            left = j;
            right = j + Grid_pixel_columns - 1;
         

            if(rowposition == Grid_size_rows - 1)
                bottom = rows; 
            end

            if(columnposition == Grid_size_columns - 1)
                right = columns; 
            end

            % testingx = (top:bottom)
            % testingy = (left:right)

            red = img(top:bottom,left:right,1);
            red = reshape(red,1,[]);
            average_red = mean(red);

            green = img(top:bottom,left:right,2);
            green = reshape(green,1,[]);
            average_green = mean(green);

            blue = img(top:bottom,left:right,3);
            blue = reshape(blue,1,[]);
            average_blue = mean(blue);

            combined_colours(end+1) = average_red;
            combined_colours(end+1) = average_green;
            combined_colours(end+1) = average_blue;
            % testing

            columnposition = columnposition + 1;
            %check my values are storing
        end

     end
       rowposition = rowposition + 1;
       columnposition = 0; 
    end
end
% histogram
F = [histogram, combined_colours];


return