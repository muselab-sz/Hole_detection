clear all


[y_hollow_0,fs_hollow] = audioread("hollow_IMG_4876.wav",[1,1e5]);
y_hollow = y_hollow_0(:,1);

y_hollow = y_hollow/range(y_hollow);
soundsc(y_hollow,fs_hollow)
%%

[y_solid_0,fs_solid] = audioread("Solid_IMG_4876.wav",[1,1e5]);
y_solid = y_solid_0(:,1);
y_solid = y_solid/range(y_solid);

soundsc(y_solid,fs_solid)

a = [y_solid; y_solid; y_hollow];
y_test = repmat(a,3,1);
%soundsc(y_test,fs_solid)
%%

Fs = fs_hollow;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 2^14;             % Length of signal
w = kaiser(L,15);

f = Fs*(0:(L/2))/L;


%%  callibrate: 

N = 11;

G_truth = zeros(L/2+1,N);

tic

for i = 1: N
    
    temp = y_solid( (i - 1)/2 * L + 1 : (i+1)/2 * L );
    Y_S = fft(temp.* w);
    P2S = abs(Y_S/L);
    P1S = P2S(1:L/2+1);
    P1S(2:end-1) = 2*P1S(2:end-1);

    G_truth(:,i) = P1S;


end


toc






for i = 1:11


figure(2)
subplot(2,1,1)
plot(f,G_truth(:,i)) 
xlim([2,24000])
ylim([ -1 * 0.001, 3 * 0.001])
xlabel("Frenquency( Hz )")
title("FFT of signal with Kaiser windowing (Ground_truth)")
% subplot(2,1,2)
% plot(f,P1S)
% xlim([2,24000])
% ylim([ -1 * 0.001, 3 * 0.001])
%title("FFT of signal with Kaiser windowing ( Solid )")
pause(0.5)
end


b = sum(G_truth,2)/ 11;

figure(2)
subplot(2,1,2)
plot(f,b) 
xlim([2,24000])
ylim([ -1 * 0.001, 3 * 0.001])
xlabel("Frenquency( Hz )")
title("FFT of average (Ground_truth)")


%%  testing: 

N = 11;

Testing = zeros(L/2+1,N);

tic

for i = 1: N
    
    temp = y_hollow( (i - 1)/2 * L + 1 : (i+1)/2 * L );
    Y_S = fft(temp.* w);
    P2S = abs(Y_S/L);
    P1S = P2S(1:L/2+1);
    P1S(2:end-1) = 2*P1S(2:end-1);

    Testing(:,i) = P1S;


end


toc






for i = 1:11


figure(3),clf
subplot(2,1,1)
plot(f,Testing(:,i)) 
xlim([2,24000])
ylim([ -1 * 0.001, 3 * 0.001])
xlabel("Frenquency( Hz )")
title("FFT of signal with Kaiser windowing (Hollow signal)")
% subplot(2,1,2)
% plot(f,P1S)
% xlim([2,24000])
% ylim([ -1 * 0.001, 3 * 0.001])
%title("FFT of signal with Kaiser windowing ( Solid )")
pause(0.5)
end


b_t = sum(Testing,2)/ 11;

figure(3)
subplot(2,1,2)
plot(f,b_t) 
xlim([2,24000])
ylim([ -1 * 0.001, 3 * 0.001])
xlabel("Frenquency( Hz )")
title("FFT of average (Hollow signal)")


%%


figure(4)

subplot(2,1,1)
plot(f,b,'r') 
hold on 
xlim([2,24000])
ylim([ -1 * 0.001, 3 * 0.001])


plot(f,b_t,'b') 
hold on 
xlim([2,24000])
ylim([ -1 * 0.001, 3 * 0.001])

xlabel("Frenquency( Hz )")
title("FFT of signal with Kaiser windowing (Ground_truth)")

% subplot(2,1,2)
% plot(f,P1S)
% xlim([2,24000])
% ylim([ -1 * 0.001, 3 * 0.001])
%title("FFT of signal with Kaiser windowing ( Solid )")