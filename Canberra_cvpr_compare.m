function dst=Canberra_cvpr_compare(F1, F2)


x = abs(F1-F2);


absolute_sum = abs(F1) + abs(F2);


dst = x / absolute_sum;


return;