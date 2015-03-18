function [ x,y,z,t,t_meander,Fs,Fs_meander] = generateSignals(  )
% x - sawtooth
% y - sin 
% z - meander
% Fs - sampling frequency for sin and sawtooth 
% t - time for sin and sawtooth
% t_meander - time for meander
% Fs_meander - sampling frequency meander
Fs = 10;                    % sampling frequency
T = 1/Fs;                     % period
L = 1000;                     % Length of signal
t = (0:L-1)*T;                % Time vector
F=10;
A=1;        % amplitude
Fs_meander=10;
T_meander=1/Fs_meander;
dt=T_meander/Fs;     % sampling period
t_meander=0:dt:1-dt;
z=(square(2*pi*t_meander*Fs_meander)*A+1)/2; 
x =sawtooth(t);
y=sin(t);
Fs_meander=1/dt;
end

