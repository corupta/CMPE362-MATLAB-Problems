% image path is "../ProvidedFiles/Hubble-Massive-Panorama.png"
rawImageData = imread("../ProvidedFiles/Hubble-Massive-Panorama.png");

grayImageData = rgb2gray(rawImageData);
% convert image to grayscale first
bwImageData = imbinarize(grayImageData);
% convert image to black and white

% imshow(bwImageData);

flippedImgData = flipud(bwImageData);
% since from bottom to top each pixel corresponds to 1-900Hz as their index
% from bottom, flip the image matrix up-down to reverse that order so that
% fourier transforms work as expected, (input for ifft resembles amplitudes
% for each frequency but each index of a vector means the frequency where
% the index is increasing from top to bottom unlike the project
% description where the index resembles frequency but increasing from
% bottom to top. That's why it was flipped up-down)

% From now on, since the data is flipped, top to bottom each pixel
% resembles its index Hz.
% Similarly amplitude parting should be reversed, from top to bottom parts
% have decreasing amplitude

amplitudes = transpose(repelem(10:-1:1, 90));
% divide each column (900 pixels) to 10 parts (90 pixel each)
% starting from the top, parts have amplitude 10, 9, 8, ..., 2, 1
% so repeat the vector 10:-1:1 elements 90 times (90 times each element for each pixel in the related part)
% Transposed to convert the row vector to column vector

freqData = bwImageData .* amplitudes;
% multiply each column with the given amplitudes

% Sampling Rate (Frequency in Hz)
Fs = 1000;
% Since each column has a length,frequencies from 1 to 900Hz require
% sampling frequency >= 900
% Since the audio device on my computer supports playing at lowest 1000Hz,
% Thus, I've chosen Fs as 1000 Hz.

% plot(1:900, freqData(:, 1))

soundData = ifft(freqData, Fs);
% ifft zero-pads the data if the Fs is bigger than the original matrix
% which is the case since Fs=1000>900, so the output data would have
% columns of size 1000 (1024 columns each of size 1000)

% each column resembles 1000 samples with sampling rate 1000 (1 second)

soundData = reshape(soundData, numel(soundData), 1);
% Concat each of these columns to obtain 1024 seconds of sound.

soundData = abs(soundData);
% Take the absolute value of each data to get real numbers to play for real

audiowrite("../CreatedAudio/SonifiedDeepSpace.wav", soundData, Fs);
% Save the created wav file

duration = length(soundData) / Fs;
% Total Duration of the sound

sound(soundData, Fs);
% Start Playing the sound generated

% Fancy remeaning duration displayer with pauses
disp(strcat("Playing the sound obtained"));
for N = 0:1/100:1
    % For each percantage of the sound played display remaining duration
    leftDuration = duration * (1-N);
    % Calculate remaining duraion
    disp(strcat(num2str(100 * N), "% =>  ", num2str(leftDuration), " seconds left until sound finishes ..."))
    % Display it
    pause(duration/100);
    % Wait for another percentage of duration until next print.
end
disp("Sound is Finished!");

