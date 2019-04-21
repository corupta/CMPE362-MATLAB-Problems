% csv path is "../ProvidedFiles/exampleSignal.csv"
signals = csvread('../ProvidedFiles/exampleSignal.csv', 0);
% signals is a one column vector (M * 1)

peakCounts = nan(1, 30);
nValues = 1:30;
for N=1:30
    % include N = 1 case, in which the filter is identity (original signal)
    hh = ones(N, 1) / N;
    % hh is a one column vector (N * 1)

    yy = conv(signals, hh);
    % yy is a one column vector (M + N - 1 * 1)

    peaks = findpeaks(yy);
    % peaks is also a column vector (S * 1)

    S = numel(peaks);
    % S is the number of peaks, tmp is one

    peakCounts(N) = S;
    % set Nth result to S
end

fig = figure();
set(fig, 'Name', 'Plot');

plot(nValues, peakCounts);
title('Number of peaks vs N-moving-average-filter (N=1 : original signal)');

disp('Press a key to move on to scatter version')
pause;

close(fig)
fig = figure();
set(fig, 'Name', 'Scatter');

scatter(nValues, peakCounts);
title('Number of peaks vs N-moving-average-filter (N=1 : original signal)');

disp('Press a key to close the figure & finish')
pause;

close(fig)