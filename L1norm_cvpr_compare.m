function dst=L1norm_cvpr_compare(F1, F2)

% This function should compare F1 to F2 - i.e. compute the distance
% between the two descriptors
%Subtracting each element
x = F1-F2;

%Squaring the differences
x = abs(x);

%Sum up the square differences
x = sum(x,"all");

%Square root of x
dst = x;

% For now it just returns a random number
% dst=rand();

return;