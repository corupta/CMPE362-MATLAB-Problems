% related audio (signal) file is at path "../ProvidedFiles/PinkPanther30.wav"
fpath = "../ProvidedFiles/PinkPanther30.wav";
[y, Fs] = audioread(fpath);
% y is the original sample matrix, Fs is the sampling rate

duration = numel(y) / Fs; % calculate the duration

sound(y, Fs);         % Play the original sound
disp("Playing the original sound");
pause(duration + 1); % Wait for the sound to finish

peakCounts = nan(1, 5);
% peakCounts 1-4 are nof peaks in filtered sound
% 5th one is the nof peaks in the original sound
% Calculate nof peaks in the original sound
peaks = findpeaks(y);
% peaks in the original sound

nofPeaks = numel(peaks);
% number of peaks in the filtered sound

peakCounts(5) =  nofPeaks;
% set the last result to the nofPeaks of original sound


for N=4:-1:1
    % Find low pass filtered signals, play them and find their peak counts.
    % 1 => 1KHz, 2 => 2 KHz, 3 => 3KHz, 4 => 4KHz
    filtered = lowpass(y, N * 1000, Fs);
    % filtered sound

    sound(filtered, Fs);       % Play the filtered sound
    disp(strcat("Playing the sound filtered by a low pass filter of ", num2str(N), "KHz"));
    pause(duration + 1); % Wait for the sound to finish

    peaks = findpeaks(filtered);
    % peaks in the filtered sound

    nofPeaks = numel(peaks);
    % number of peaks in the filtered sound

    peakCounts(N) = nofPeaks;
    % set Nth result to the found nofPeaks
end

labels = {"1000Hz", "2000Hz", "3000Hz", "4000Hz", "No Filter"};
% first 4 values are the applied filters 1000Hz, 2000Hz, 3000Hz, 4000Hz
% last one is for no filter (original sound)

fig = figure();
set(fig, 'Name', 'Bar');

bar(peakCounts);
xticklabels(labels);
title('Number of peaks vs changing low pass filter frequency (Hz)');


disp('Press a key to move on to line plot version')
pause;

close(fig)
fig = figure();
set(fig, 'Name', 'Line Plot');

plot(peakCounts);
title('Number of peaks vs changing low pass filter frequency (Hz)');
xticks(1:5);
xticklabels(labels);

disp('Press a key to close the figure & finish')
pause;

close(fig)
