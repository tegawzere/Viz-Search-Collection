%so far the color grid seems less accurate than the histogram BUT that is
%with the euclidean distance formula
function F=Colour_Grid_extractRandom(img)
%hard code the size of the grid in this just like for quantization 
Grid_size_rows = 4;
Grid_size_columns = 4; 

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

% for i=1:imagerows:rows
%     for j=1:imagecolumns:columns
%         x = round(i * imageColumn);
%         if x <= size(img,2)
%             img(:,x,:) = [255,0,0];
%             red = img(i1:i+3,j1:j+3,1);
%             red = reshape(red,1,[]);
%             average_red = mean(red);
% 
%             green = norm_img(i1:i+3,j1:j+3,2);
%             green = reshape(green,1,[]);
%             average_green = mean(green);
% 
%             blue = norm_img(i1:i+3,j1:j+3,3);
%             blue = reshape(blue,1,[]);
%             average_blue = mean(blue);
%         end
%         y = round(i * imageRow);
%         if y <= size(img,1)
%             img(y,:,:) = [255,0,0];
%             red = norm_img(:,:,1);
%             red = reshape(red,1,[]);
%             average_red = mean(red);
%         end
%     end
% 
% 
% end

F = combined_colours;



% F=rand(1,30);

% Returns a row [rand rand .... rand] representing an image descriptor
% computed from image 'img'

% Note img is a normalised RGB image i.e. colours range [0,1] not [0,255].


%normalise the image first then because you kept getting the array index
%error
% norm_img = mat2gray(img);
% norm_img = im2double(img);
% norm_img = img;
% 
% %this works but only for the flowers
% norm_img = rescale(img, 0, 255);
% 
% % norm_img = img / max(img(:));
% % 
% red = norm_img(:,:,1);
% red = reshape(red,1,[]);
% average_red = mean(red);
% % % [yRed, x] = imhist(red);
% hist_red = imhist(red);
% % 
% % 
% green = norm_img(:,:,2);
% green = reshape(green,1,[]);
% average_green = mean(green);
% % % [yGreen, x] = imhist(green);
% hist_green = imhist(green);
% % 
% blue = norm_img(:,:,3);
% blue = reshape(blue,1,[]);
% average_blue = mean(blue);
% % % [yBlue, x] = imhist(blue);
% hist_blue = imhist(blue);
% % 
% % 
% % % F = [[yRed,x] [yGreen,x] [yBlue,x]]
% F = [hist_red hist_green hist_blue];
% F = [ average_red average_green average_blue ];
% % 
% h = histogram(randn(10,1));
% c = h.BinWidth;
% % h.binWidth = 2;
% norm_img = img * 255;
% 
% amount_bins = 256;
% 
% [countsRed, locationsRed] = imhist(norm_img(:,:,1), amount_bins);
% [countsGreen, locationsGreen] = imhist(norm_img(:,:,2), amount_bins);
% [countsBlue, locationsBlue] = imhist(norm_img(:,:,3), amount_bins);
% 
% F = [ [countsRed, locationsRed] [countsGreen, locationsGreen] [countsBlue, locationsBlue] ];

% numBins = 256;
% 
% %channels
% red = img(:,:,1);
% green = img(:,:,2);
% blue = img(:,:,3);
% 
% %histograms
% % red_hist = imhist(red, numBins);
% % green_hist = imhist(green, numBins);
% % blue_hist = imhist(blue, numBins);
% % 
% % F = [red_hist green_hist blue_hist]; 
% % 
% % F = F / sum(F);
% % 
% % %Transpose to row vector because right now its one column
% % F = F(:)';
% 
% 
% 
% 
% % from his lecture slides also gets flowers 
% 
% %experiment with quantization means trying different things
% %for example with quantization, try different levels to show that 
% %you tried different things. pick your best one. trial and error => show on
% %report.
% Q = 5;
% % qimg = double(img)./ 256;
% qimg = floor(img.*Q); 
% 
% 
% bin = qimg(:,:,1) * Q^2 + qimg(:,:,2) * Q^1 + qimg(:,:,3);
% 
% 
% vals = reshape(bin, 1, size(bin,1)*size(bin,2));
% 
% F = hist(vals,Q^3);
% 
% F = F ./ sum(F);
% % F = F';


 



return;