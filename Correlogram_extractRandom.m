function F = Correlogram_extractRandom(img)

% Convert image to indexed image to reduce the number of colors
% This is useful to make the correlogram computation tractable
[imgInd, map] = rgb2ind(img, 32); % Using 64 colors for illustration

% Define the distances at which to compute the correlogram
distances = [1, 2, 4, 8]; % You can choose the distances that make sense for your application

% Initialize the correlogram
correlogram = zeros(size(map, 1), size(map, 1), numel(distances));

% Compute the correlogram
for d = 1:numel(distances)
    for colour1 = 1:size(map, 1)
        for colour2 = 1:size(map, 1)
            correlogram(colour1, colour2, d) = colourPairsProb(imgInd, colour1-1, colour2-1, distances(d));
        end
    end
end

F = correlogram(:)';

return;