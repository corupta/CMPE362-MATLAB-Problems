% sound file path is "../ProvidedFiles/mike.wav"

hfile = '../ProvidedFiles/mike.wav';

% read the audio file, y is data, Fs is number of samples per second
[signal, Fs] = audioread(hfile);

% calculate duration
duration = numel(signal) / Fs;

% listen back read audio
sound(signal, Fs);
pause(duration + 2);

% PART 1 - Constant N and K, change alpha from 0 to 1
N = 25;
K = 0.1;

alphaValues = 0:0.01:1;

valueCount = numel(alphaValues);

SNRValues = nan(1, valueCount);

for i = 1:valueCount
    alpha = alphaValues(i);
    % check out NTapFilterSNR.m file for the below function definition
    SNRValue = NTapFilterSNR(signal, Fs, N, K, alpha);
    SNRValues(i) = SNRValue;
end

fig = figure(); set(fig, 'Name', 'Plot of constant N(25), K(100ms) - varying \alpha 0 to 1');
plot(alphaValues, SNRValues);title('Constant N(25), K(100ms) - varying \alpha 0 to 1');
xlabel('0 <= \alpha <= 1');ylabel('SNR (dB)');

disp('Press a key to move on to part 2')
pause
close(fig);

% PART 2 - Constant alpha and K, change N from 1 to 50

K = 0.1;
alpha = 0.5;

NValues = 1:50;

SNRValues = nan(1, 50);

for N = NValues
    SNRValues(N) = NTapFilterSNR(signal, Fs, N, K, alpha);
end

fig = figure(); set(fig, 'Name', 'Plot of constant K(100ms), \alpha(0.5) - varying N 1 to 50');
plot(NValues, SNRValues);title('Constant K(100ms), \alpha(0.5) - varying N 1 to 50');
xlabel('1 <= N <= 50');ylabel('SNR (dB)');

disp('Press a key to move on to part 3')
pause
close(fig);

% PART 3 - Constant N, and alpha, change K from 100ms, 200ms, 300ms, 400ms, 500ms
N = 25;
alpha = 0.5;

KValues = 0.1:0.1:0.5;

SNRValues = nan(1, 5);

for i = 1:5
    SNRValues(i) = NTapFilterSNR(signal, Fs, N, KValues(i), alpha);
end

fig = figure(); set(fig, 'Name', 'Plot of constant N(25), \alpha(0.5) - varying K in 100ms, 200ms, 300ms, 400ms, 500ms');
plot(KValues, SNRValues);title('Constant N(25), \alpha(0.5) - varying K in 100ms, 200ms, 300ms, 400ms, 500ms');
xlabel('K \in { 100ms, 200ms, 300ms, 400ms, 500ms }');ylabel('SNR (dB)');

disp('Press a key to close the plot and finish')
pause
close(fig);

% Test a sound

testSound = signal;
for i = 1:25
    testSound = testSound + (-0.5)^i * delayseq(signal, 0.1 * i, Fs);
end

testSNRValue = snr(signal, testSound - signal);

disp('snr of test value');
disp(testSNRValue);

sound(testSound, Fs)
