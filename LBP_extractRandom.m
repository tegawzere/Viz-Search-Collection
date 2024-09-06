function F=LBP_extractRandom(img)

gray_img = rgb2gray(img); 

numBins = 256;


img_lbp = zeros(size(gray_img));

for i = 2:size(gray_img, 1)-1
    for j = 2:size(gray_img, 2)-1
        % Extract the 3x3 neighbourhood
        neighborhood = gray_img(i-1:i+1, j-1:j+1);
        
        % Threshold the neighborhood
        thresholded = neighborhood >= neighborhood(2,2);
        
        % Convert binary values to decimal
        lbpValue = binaryVectorToDecimal(thresholded(:)');
        
        % Assign the LBP value to the center pixel
        img_lbp(i,j) = lbpValue;
    end
end

% Calculate the LBP histogram
F = hist(img_lbp(:), numBins);

% Normalize the histogram
F = F ./ sum(F);

% Ensure the output is a row vector
% F = F(:)';

return;




