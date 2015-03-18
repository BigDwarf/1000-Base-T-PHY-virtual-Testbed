function [f,Y,NFFT] = spectrum(data,time, Fs )

T = 1/Fs;                     % Sample time
L = length(data);                     % Length of signal
%ylim([min(data)-1 max(data)+1])
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(data,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

end

