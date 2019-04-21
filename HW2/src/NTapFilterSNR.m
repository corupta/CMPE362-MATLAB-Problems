function Y = NTapFilterSNR(signal, Fs, N, K, alpha)
% NtapFilterSNR     filter given signal through an N-Tap Filter and
%                   return the SNR value of the output and input signal
%
%   usage:          Y = NTapFilterSNR(signal, N, K, alpha)
%
%       signal  -   input signal vector
%           Fs  -   sampling frequency of the input signal vector
%            N  -   N value (number of delayed signals added to original signal)
%            K  -   unit delay value in seconds
%        alpha  -   unit coefficient of each delayed signal
%
%       output signal = Y = signal - alpha * delayed(signal, K) + alpha^2 * delayed(signal, 2*K)
%                        + ... (-alpha)^N * delayed(signal, N*K)
%
%       Then, calculate SNR of Y to signal according to below equation
%       SNR = 10log(sum(signal .^ 2) / sum( (Y - signal) .^ 2) )


recovered = signal;
for i = 1:N
    recovered = recovered + (-alpha)^i * delayseq(signal, K * i, Fs);
end

Y = snr(signal, recovered - signal);
