function F=GlobalColourHisto_extractRandom(img)

% F=rand(1,30);

% Returns a row [rand rand .... rand] representing an image descriptor
% computed from image 'img'

% Note img is a normalised RGB image i.e. colours range [0,1] not [0,255].


%normalise the image first then because you kept getting the array index
%error
% norm_img = mat2gray(img);
% norm_img = im2double(img);
norm_img = img;
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

numBins = 256;

%channels
red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);

%histograms
% red_hist = imhist(red, numBins);
% green_hist = imhist(green, numBins);
% blue_hist = imhist(blue, numBins);
% 
% F = [red_hist green_hist blue_hist]; 
% 
% F = F / sum(F);
% 
% %Transpose to row vector because right now its one column
% F = F(:)';




% from his lecture slides also gets flowers 

%experiment with quantization means trying different things
%for example with quantization, try different levels to show that 
%you tried different things. pick your best one. trial and error => show on
%report.
Q = 5;
% qimg = double(img)./ 256;
qimg = floor(img.*Q); 


bin = qimg(:,:,1) * Q^2 + qimg(:,:,2) * Q^1 + qimg(:,:,3);


vals = reshape(bin, 1, size(bin,1)*size(bin,2));

F = hist(vals,Q^3);

F = F ./ sum(F);
% F = F';


 



return;