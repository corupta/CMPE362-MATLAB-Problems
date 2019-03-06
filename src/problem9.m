% csv path is "../ProvidedFiles/exampleSignal.csv"
% skipping first three elements as suggested in https://canvas.instructure.com/courses/1533310/discussion_topics/7501485
signals = csvread('../ProvidedFiles/exampleSignal.csv', 3);
% convert from raw matrix to column matrix
signals = signals.';
[a, len] = size(signals);
times = 1:len;
[peaks, peakTimes] = findpeaks(signals);

subplot(2, 1, 1); plot(times, signals); title('original signal');
subplot(2, 1, 2); scatter(peakTimes, peaks); title('peaks found');
size(signals)
size(peaks)