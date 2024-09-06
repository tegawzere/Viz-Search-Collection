%%helper function for binary to Decimal 
function dec = binaryVectorToDecimal(binVec)
    dec = 0;
    for k = 1:length(binVec)
        dec = dec + binVec(k) * 2^(length(binVec) - k);
    end
end