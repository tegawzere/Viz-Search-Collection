function dst=Colour_Grid_cvpr_compare(F1, F2,eigen_infoval)

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

%trial 1
% For now it just returns a random number
% dst=rand();
% 
% % target_obs1 = [reshape(F1(:,:,1),1,[]) ; reshape(F1(:,:,2),1,[]) ;
% % reshape(F1(:,:,3),1,[]) ];
% 
% % target_e1 = Eigen_Build(target_obs1);
% target_e1 = Eigen_Build(F1);
% 
% % target_obs2 = [reshape(F2(:,:,1),1,[]) ; reshape(F2(:,:,2),1,[]) ;
% % reshape(F2(:,:,3),1,[]) ];
% 
% mdst = Eigen_Mahalanobis(F2, target_e1);
% 
% % result = reshape(mdst,size(F2,1),size(F2,2));
% 
% nresult=mdst./ max(max(mdst));
% 
% imgshow(nresult);
% 
% dst = mdst;

%2nd time
% x = F2(:,1,1);
% 
% xsub = x - (Eigen_Build(F1).org);
% 
% V= diag(Eigen_Build(F1).val);
% U= Eigen_Build(F1).vct;
% 
% mdst_squared = xsub' * U * inv(V) * U' * xsub;
% 
% dst = sqrt(mdst_squared);

%3rd time

x = F1 -F2;

x = x.^2;

x = x./eigen_infoval';

x = sum(x);

dst = sqrt(x);





return;