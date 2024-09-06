function dst=Minkowski_cvpr_compare(F1, F2)

% This function compares F1 to F2 by computing the Minkowski distance
% between the two descriptors for a given order n
minkowski_order = 3;

% Compute the absolute differences raised to the power of n
differences_nth_power = abs(F1 - F2) .^ minkowski_order;


sum_nth_power_differences = sum(differences_nth_power, "all");

dst = sum_nth_power_differences ^ (1 / minkowski_order);

return;

