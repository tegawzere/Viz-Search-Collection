function dst=Mahalanobis_cvpr_compare(F1, F2, eigen_infoval)

% % This function should compare F1 to F2 - i.e. compute the distance
% % between the two descriptors
% %Subtracting each element
% x = F1-F2;
% 
% %Squaring the differences
% x = x.^2;
% 
% %Sum up the square differences
% x = sum(x,"all");
% 
% %Square root of x
% dst = sqrt(x);
% 
% % For now it just returns a random number
% % dst=rand();

x = F1 -F2;

x = x.^2;

x = x./eigen_infoval';

x = sum(x);

dst = sqrt(x);


return;
