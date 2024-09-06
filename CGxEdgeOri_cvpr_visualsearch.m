function [testing, final_precision, final_recall, for_graph] = CGxEdgeOri_cvpr_visualsearch(query_input, distance_query)

% start = 0;
% close all;
clearvars -except query_input distance_query;


%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = '/Users/tegaorogun./Documents/PatternRecAssignment/MSRCObjCategImageDatabasev2';

%% Folder that holds the results...
DESCRIPTOR_FOLDER = '/Users/tegaorogun./Documents/PatternRecAssignment/DescriptorFolder';
%% and within that folder, another folder to hold the descriptors
%% we are interested in working with
DESCRIPTOR_SUBFOLDER='DescriptorSubfolder';
num_of_files = 591;

%% 1) Load all the descriptors into "ALLFEAT"
%% each row of ALLFEAT is a descriptor (is an image)
testing = 0;
ALLFEAT=[];
ALLFILES=cell(1,0);
ctr=1;
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    % fname
    testing = testing + 1;
    % testing
    % image_key_relevance = strtok(fname,'_');
    % if strcmp(query_image_key, image_key_relevance)
    %     similar_max = similar_max + 1;
    % end

    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    thesefeat=[];
    featfile=[DESCRIPTOR_FOLDER,'/',DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    load(featfile,'F');
    ALLFILES{ctr}=imgfname_full;
    ALLFEAT=[ALLFEAT ; F];
    ctr=ctr+1;
end

%use PCA and the eigen_build
%get the eigenvalues of all the images loaded into ALLFEAT
% eigen_info = Eigen_Build(ALLFEAT');
% if_useful_eigen = 0;
% 
% summed_up_eigenvalue = sum(eigen_info.val);
% summed_up_eigenvalue = summed_up_eigenvalue*0.91;
% for_image = 0;
% 
% for i=1:size(eigen_info.val)
%     if(for_image < summed_up_eigenvalue)
%         for_image = for_image + eigen_info.val(i);
%         if_useful_eigen = if_useful_eigen + 1;
%     end 
% end
% 
% eigen_info = Eigen_Deflate(eigen_info,'keepn',if_useful_eigen);
% ALLFEAT=Eigen_Project(ALLFEAT',eigen_info)';




%% 2) Pick an image at random to be the query
NIMG=size(ALLFEAT,1);           % number of images in collection
% queryimg=floor(rand()*NIMG);    % index of a random image
queryimg = query_input;
queryimg

if strcmp(distance_query,'Mahalanobis')
    eigen_info = Eigen_Build(ALLFEAT');
    if_useful_eigen = 0;

    summed_up_eigenvalue = sum(eigen_info.val);
    % summed_up_eigenvalue = summed_up_eigenvalue*0.95; this works kinda
    % well
    summed_up_eigenvalue = summed_up_eigenvalue*0.90;
    % summed_up_eigenvalue
    for_image_empty_spaces = 0;

    for i=1:size(eigen_info.val)
        if(for_image_empty_spaces < summed_up_eigenvalue)
            for_image_empty_spaces = for_image_empty_spaces + eigen_info.val(i);
            % for_image_empty_spaces
            if_useful_eigen = if_useful_eigen + 1;
        end 
    end

    eigen_info = Eigen_Deflate(eigen_info,'keepn',if_useful_eigen);
    ALLFEAT= Eigen_Project(ALLFEAT',eigen_info)';

    %can't figure out how to also project the query image without breaking
    %everything
    % query = Eigen_Project(ALLFEAT(queryimg)', eigen_info)';
    
end

%% 3) Compute the distance of image to the query
dst=[];
for i=1:NIMG
    candidate=ALLFEAT(i,:);
    
    switch distance_query
        case 'Euclidean'
            query=ALLFEAT(queryimg,:);
        case 'Mahalanobis'
            query=ALLFEAT(queryimg,:);
        case 'L1'
            query=ALLFEAT(queryimg,:);
        case 'Canberra'
            query=ALLFEAT(queryimg,:);
        case 'Minkowski'
            query=ALLFEAT(queryimg,:);
        otherwise
            error('Distance Variable Invalid')
    end

    % query=ALLFEAT(queryimg,:);
    % distance_query
    % query
    switch distance_query
        case 'Euclidean'
            thedst = Euclidean_cvpr_compare(query,candidate);
        case 'Mahalanobis'
            thedst = Mahalanobis_cvpr_compare(query,candidate, eigen_info.val);
        case 'L1'
            thedst = L1norm_cvpr_compare(query,candidate);
        case 'Canberra'
            thedst = Canberra_cvpr_compare(query,candidate);
        case 'Minkowski'
            thedst = Minkowski_cvpr_compare(query,candidate);
        otherwise
            error('Distance Variable Invalid')
    end

    % if strcmp(distance_query, 'Euclidean')
    %     thedst = Euclidean_cvpr_compare(query,candidate);
    % 
    % 
    % elseif strcmp(distance_query, 'L1')
    %     thedst = L1norm_cvpr_compare(query,candidate);
    % 
    % 
    % elseif strcmp(distance_query, 'Mahala')
    %     thedst = Mahalanobis_cvpr_compare(query,candidate, eigen_info.val);
    % 
    % elseif strcmp(distance_query, 'Canberra')
    %     thedst = Canberra_cvpr_compare(query,candidate);
    % else
    %     thedst=Colour_Grid_cvpr_compare(query,candidate,eigen_info.val);
    % end    
    
    dst=[dst ; [thedst i]];
end
dst=sortrows(dst,1);  % sort the results
size(dst)



%% 4) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)

SHOW=591; % Show top 15 results
dst=dst(1:SHOW,:);
outdisplay=[];
for i=1:size(dst,1)
   % if dst(i,2) >= 1 && dst(i,2) <= numel(ALLFILES)
   %  img = imread(ALLFILES{dst(i,2)});
   % else
   %  % Handle out-of-bounds index, for example:
   %  disp('Index is out of bounds.');
   % end 
   img=imread(ALLFILES{dst(i,2)});
   img=img(1:2:end,1:2:end,:); % make image a quarter size
   img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
   outdisplay=[outdisplay img];
end

imgshow(outdisplay);
axis off;
figure



% Precision Recall
% should be 30 as there are 10 images that would show that the precision is
% 100% accurate
similar = 0;
similar_max = 0;
%getting the number from the file name so i can use the number to help out
%with the precision recall calculation
query_image_key = strtok(ALLFILES{queryimg}, '_');
[~, filename, ~] = fileparts(query_image_key);

%just in case i need the file number as an integer...probably not Tega.
numero = str2double(filename);
query_key = filename;

% query_image_key = filename;

keys = strtok(query_image_key, '/');
query_image_key = char(keys(end));
relevant = 0;

groundTruth = [];

%True Postives and False Positives
TP = 0;
FP = 0;

precision = [];
recall = [];
precision_sum = 0;

%scanning through all the documents again to check all the relevant images
%that go with the query image
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    image_key_relevance = strtok(fname,'_');
    [~, filename, ~] = fileparts(image_key_relevance);
    image_key = filename;
    if strcmp(query_key, image_key)
        %this sets the actual amount of images that matter to the query
        %image. generally, this should add up to 30.
        similar_max = similar_max + 1;
    end
end

%looping over the images that were returned after the descriptor and
%analysis. SHOW = 10.
for i= 1:SHOW
    name_of_file = ALLFILES{dst(i,2)};
    file_keyword = strtok(name_of_file,'_');
    [~, filename, ~] = fileparts(file_keyword);
    file_keyword = filename;

    if (strcmp(query_key, file_keyword))
        %similar will go up to see if the chosenimage is in the same
        %category as the query image
        similar = similar + 1;
        relevant = 1;
    end



    % displayedImageIndex = dst(i,2);
    % 
    % if groundTruthQuery(displayedImageIndex) == 1
    %     TP = TP + 1;
    % else
    %     FP = FP + 1;
    % end
    precision(i) = similar / i;
    % precision_sum = precision_sum + (precision(i)*relevant);
    recall(i) = similar / similar_max; %should be divided by 30
    
    fprintf('Precision: %.2f\n', precision(i));
    fprintf('Recall: %.2f\n', recall(i));
    precision_sum = precision_sum + (precision(i) * relevant);
    relevant = 0; 

end

average_precision = precision_sum / similar_max;
fprintf('Average Precision: %.2f\n', average_precision);

file_keyword = strtok(name_of_file,'_');

testing = average_precision;

final_precision = precision;
final_recall = recall;
for_graph = outdisplay;

return

%Books -> queryimg = 100(13_13?), 110,  
%Face -> queryimg = 486(6_23)
%Building -> queryimg = 410(3_8), 401, 387(pretty bad here), 
%Dog -> queryimg = 187(16_16), 201
%Bicycle -> queryimg = 561(8_9)
%Flowers -> queryimg = 20(10_..)
%Water/Boat -> queryimg = 259(18_27), 263, 
%Road/Building -> queryimg = 225(17_...)
%Cow/Grass -> queryimg = 452(5_..), 469, 446, 443(pretty good considering
%grass in other groups)
%Body/Face -> queryimg = 289(19_...), 294
%Tree/Grass/Sky -> queryimg = 381(2_...)(colour histogram is apparently
%really good)
%Aeroplane/Grass/Sky -> queryimg = 419(4_...)
%Cat -> queryimg = 163(15_...)
%Bird -> queryimg = 96(12_...), 70
%Sheep/grass -> queryimg = 567(9_...)
%Water/boat/sky(this is similar to 18 might want to skip or add the two
%descriptors together when testing) -> queryimg = 345(20_...)
%Chair/Benches -> queryimg = 132(14_...)




% precision(i) = similar / i;
% recall(i) = similar / similar_max; %should be divided by 30 

