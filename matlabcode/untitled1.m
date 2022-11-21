clear all


[y_hollow_0,fs_hollow] = audioread("hollow_IMG_4876.wav",[10000,10000+16383]);
y_hollow = y_hollow_0(:,1);

y_hollow = y_hollow/range(y_hollow);
%soundsc(y_hollow,fs_hollow)

[y_solid_0,fs_solid] = audioread("Solid_IMG_4876.wav",[55000,55000+16383]);
y_solid = y_solid_0(:,1);
y_solid = y_solid/range(y_solid);
%soundsc(y_solid,fs_solid)

figure(10)
subplot(2,1,1)
plot([1:length(y_hollow)]/fs_hollow,y_hollow)
axis tight
xlabel("Time")
ylabel("Normalized signal")
title("Sound wave of hollow sound, two punch")
subplot(2,1,2)
plot([1:length(y_solid)]/fs_solid,y_solid)
title("Sound wave of hollow sound, two punch")
axis tight
xlabel("Time")
ylabel("Normalized signal")

%%

figure(5)
subplot(2,1,1)
stft(y_hollow,fs_hollow,'Window',kaiser(256,5),'OverlapLength',220,'FFTLength',512);
subplot(2,1,2)
stft(y_solid,fs_solid,'Window',kaiser(256,5),'OverlapLength',220,'FFTLength',512);


%%
Fs = 48000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(y_hollow);             % Length of signal

w = kaiser(L,0.2);


tic
Y_H = fft(y_hollow.* w);
toc

Y_S = fft(y_solid.* w);

P2H = abs(Y_H/L);
P1H = P2H(1:L/2+1);
P1H(2:end-1) = 2*P1H(2:end-1);
f = Fs*(0:(L/2))/L;

P2S = abs(Y_S/L);
P1S = P2S(1:L/2+1);
P1S(2:end-1) = 2*P1S(2:end-1);



figure(6)
subplot(2,1,1)
plot(f,P1H) 
xlim([2,24000])
ylim([ -1 * 0.001, 3 * 0.001])
xlabel("Frenquency( Hz )")
title("FFT of signal with Kaiser windowing (Hollow)")
subplot(2,1,2)
plot(f,P1S)
xlim([2,24000])
ylim([ -1 * 0.001, 3 * 0.001])
title("FFT of signal with Kaiser windowing ( Solid )")



tic
sum(P1S(200: 800))
sum(P1H(200: 800))
toc

