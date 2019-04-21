% image path is "../ProvidedFiles/lena.png"
rawImageData = imread('../ProvidedFiles/lena.png');
grayImageData = rgb2gray(rawImageData);

[n, m] = size(grayImageData);
% reshape image data to a row vector for std calculation and more
grayImageVector = reshape(grayImageData, [1, n * m]);

[minValue, minIndex] = min(grayImageVector);
[minLocationN, minLocationM] = ind2sub([n,m], minIndex);
[maxValue, maxIndex] = max(grayImageVector);
[maxLocationN, maxLocationM] = ind2sub([n,m], maxIndex);

% std (=> var method) expects the elements to be single/double
grayImageVector = double(grayImageVector);

meanValue = mean(grayImageVector);
stdValue = std(grayImageVector);

disp('All calculations have finished')
disp(['Mean: ', num2str(meanValue)])
disp(['Standard Deviation: ', num2str(stdValue)])
disp(['Minimum: ', num2str(minValue), ...
    ' at location: (', num2str(minLocationN), ...
    ', ', num2str(minLocationM), ')'])
disp(['Maximum: ', num2str(maxValue), ...
    ' at location: (', num2str(maxLocationN), ...
    ', ', num2str(maxLocationM), ')'])

