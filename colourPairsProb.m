function probability = colourPairsProb(imgInd, color1, color2, distance)
    [rows, cols] = size(imgInd);
    countColourPairs = 0;
    countColour1 = 0;
    
    for row = 1:rows
        for col = 1:cols
            if imgInd(row, col) == color1
                % Increase the count of color1
                countColour1 = countColour1 + 1;
                
                % Check the surrounding pixels at the specified distance
                for dRow = -distance:distance
                    for dCol = -distance:distance
                        if (dRow ~= 0 || dCol ~= 0) && ... % Not the center pixel
                           (row+dRow > 0 && row+dRow <= rows) && ... % Within bounds
                           (col+dCol > 0 && col+dCol <= cols) % Within bounds
                           
                            if imgInd(row+dRow, col+dCol) == color2
                                % Increase the count of color pairs
                                countColourPairs = countColourPairs + 1;
                            end
                        end
                    end
                end
            end
        end
    end
    
    % Calculate the probability
    probability = countColourPairs / countColour1;
    
return;