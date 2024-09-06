
books_query = 100;
plane_query = 419;
dogs_query = 187;
bikes_query = 561;
trees_query = 381; 


%%%%DISTANCE MEASURES: COPY AND PASTE THESE TO CHANGE THEM %%%%%%%%%%%%
%%%%%%%%%%%%% Euclidean  Mahalanobis  L1  Canberra  Minkowski                       %%%%%%%%%%%%
dist_string = 'Mahalanobis';



% Colour Grid
[books, books_precision, books_recall, books_graph] = Colour_Grid_cvpr_visualsearch(books_query,dist_string);
[plane, plane_precision, plane_recall, plane_graph] = Colour_Grid_cvpr_visualsearch(plane_query,dist_string);
[dogs, dogs_precision, dogs_recall, dogs_graph] = Colour_Grid_cvpr_visualsearch(dogs_query,dist_string);
[bikes, bikes_precision, bikes_recall, bikes_graph] = Colour_Grid_cvpr_visualsearch(bikes_query,dist_string);
[trees, trees_precision, trees_recall,trees_graph] = Colour_Grid_cvpr_visualsearch(trees_query,dist_string);

% Edge Orientation
% [books, books_precision, books_recall,books_graph] = EdgeOriHistogram_cvpr_visualsearch(books_query,dist_string);
% [plane, plane_precision, plane_recall,plane_graph] = EdgeOriHistogram_cvpr_visualsearch(plane_query,dist_string);
% [dogs, dogs_precision, dogs_recall,dogs_graph] = EdgeOriHistogram_cvpr_visualsearch(dogs_query,dist_string);
% [bikes, bikes_precision, bikes_recall,bikes_graph] = EdgeOriHistogram_cvpr_visualsearch(bikes_query,dist_string);
% [trees, trees_precision, trees_recall,trees_graph] = EdgeOriHistogram_cvpr_visualsearch(trees_query,dist_string);

% Global Colour Histogram
% [books, books_precision, books_recall, books_graph] = GlobalColourHisto_cvpr_visualsearch(books_query,dist_string);
% [plane, plane_precision, plane_recall, plane_graph] = GlobalColourHisto_cvpr_visualsearch(plane_query,dist_string);
% [dogs, dogs_precision, dogs_recall, dogs_graph] = GlobalColourHisto_cvpr_visualsearch(dogs_query,dist_string);
% [bikes, bikes_precision, bikes_recall, bikes_graph] = GlobalColourHisto_cvpr_visualsearch(bikes_query,dist_string);
% [trees, trees_precision, trees_recall, trees_graph] = GlobalColourHisto_cvpr_visualsearch(trees_query,dist_string);

%Colour Grid and Edge Orientation Histogram
% [books, books_precision, books_recall,books_graph] = CGxEdgeOri_cvpr_visualsearch(books_query,dist_string);
% [plane, plane_precision, plane_recall,plane_graph] = CGxEdgeOri_cvpr_visualsearch(plane_query,dist_string);
% [dogs, dogs_precision, dogs_recall,dogs_graph] = CGxEdgeOri_cvpr_visualsearch(dogs_query,dist_string);
% [bikes, bikes_precision, bikes_recall,bikes_graph] = CGxEdgeOri_cvpr_visualsearch(bikes_query,dist_string);
% [trees, trees_precision, trees_recall,trees_graph] = CGxEdgeOri_cvpr_visualsearch(trees_query,dist_string);


%Local Binary Pattern 
% [books, books_precision, books_recall,books_graph] = LBP_cvpr_visualsearch(books_query,dist_string);
% [plane, plane_precision, plane_recall,plane_graph] = LBP_cvpr_visualsearch(plane_query,dist_string);
% [dogs, dogs_precision, dogs_recall,dogs_graph] = LBP_cvpr_visualsearch(dogs_query,dist_string);
% [bikes, bikes_precision, bikes_recall,bikes_graph] = LBP_cvpr_visualsearch(bikes_query,dist_string);
% [trees, trees_precision, trees_recall,trees_graph] = LBP_cvpr_visualsearch(trees_query,dist_string);


%COLOUR CORRELOGRAM
% [books, books_precision, books_recall, books_graph] = Correlogram_cvpr_visualsearch(books_query,'Euclidean');
% [plane, plane_precision, plane_recall, plane_graph] = Correlogram_cvpr_visualsearch(plane_query,'Euclidean');
% [dogs, dogs_precision, dogs_recall, dogs_graph] = Correlogram_cvpr_visualsearch(dogs_query,'Euclidean');
% [bikes, bikes_precision, bikes_recall, bikes_graph] = Correlogram_cvpr_visualsearch(bikes_query,'Euclidean');
% [trees, trees_precision, trees_recall,trees_graph] = Correlogram_cvpr_visualsearch(trees_query,'Euclidean');

% books_precision
% books_recall
% 
% flowers_precision
% flowers_recall
% 
% dogs_precision
% dogs_recall
% 
% bikes_precision
% bikes_recall    

%MAYBE USE MEAN FUNCTION IF YOU'RE BOTHERED 
mean_average_precision = (books + plane + dogs + bikes + trees) / 5;

mean_average_precision




plot(books_recall,books_precision, 'DisplayName', 'Books');
hold on;
plot(plane_recall,plane_precision,'DisplayName', 'Plane');
hold on;
plot(dogs_recall,dogs_precision,'DisplayName', 'Dogs');
hold on;
plot(bikes_recall,bikes_precision,'DisplayName', 'Bikes');
hold on;
plot(trees_recall,trees_precision,'DisplayName', 'Trees');
hold on;
xlabel('Recall');
ylabel('Precision');
legend('Books','Plane','Dogs','Bikes','Trees');
% CHANGE TITLE FOR THE DIFFERENT DESCRIPTORS AND TESTS 
% title(sprintf('Mean Average Precision: %.3f. Quantizations level: 5\n', mean_average_precision));

title(sprintf('Mean Average Precision: %.3f. Neighbourhood: 3x3. Distance Measure: %s\n', mean_average_precision,dist_string));

% legend(gca,'show');
hold off;



figure
books_results = subplot(5,1,1), imshow(books_graph); 
flowers_results = subplot(5,1,2), imshow(plane_graph);
dogs_results = subplot(5,1,3), imshow(dogs_graph); 
bikes_results = subplot(5,1,4), imshow(bikes_graph);
trees_results = subplot(5,1,5), imshow(trees_graph);
% 
% set(plot1, 'Position', [0 0.3 1 1]);
% set(plot2, 'Position', [0 0.2 1 1]);
% set(plot3,'Position',[0 0.1 1 1]);
% set(plot4,'Position', [0 0 1 1]);
% set(plot5,'Position', [0 -0.1 1 1]);
% 
% figure('Name', 'PR Statistics for Euclidean distance and Q=2');
% plot(books_recall,books_precision,'DisplayName', 'Cow');
% hold on;
% plot(flowers_recall,flowers_precision, 'DisplayName', 'Tree');
% hold on;
% plot(dogs_recall,dogs_precision, 'DisplayName', 'Plane');
% hold on;
% plot(bikes_recall,bikes_precision, 'DisplayName', 'Book');
% hold on;
% plot(trees_recall,trees_precision, 'DisplayName', 'Bench');
% hold on;
% strTitle = sprintf('Euclidean distance and Q=2, MAP = %.2d',  round(mean_average_precision,3));
% title(strTitle);
% xlabel('Recall');
% ylabel('Precision');
% legend(gca, 'show');
% hold off;



