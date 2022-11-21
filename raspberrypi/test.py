'''
Description: 
Author: hecai
Date: 2022-05-27 10:35:20
LastEditTime: 2022-05-27 10:58:52
FilePath: \raspberrypi\test.py
'''
# %%
from os.path import dirname, join as pjoin
from scipy.io import wavfile
import scipy.io
import matplotlib.pyplot as plt
import numpy as np

# %%

from scipy import signal
from scipy.fft import fft, fftshift
import matplotlib.pyplot as plt




# %%
Fs_solid, y_solid_temp = wavfile.read("Solid_IMG_4876.wav" )
Fs_hollow, y_hollow_temp = wavfile.read("hollow_IMG_4876.wav")

y_solid = y_solid_temp[:, 0]
y_hollow = y_hollow_temp[:, 0]

y_s0 = y_solid[10000:10000+ 16384].astype(np.float)
y_h0 = y_hollow[52000:52000+ 16384].astype(np.float)

y_s = y_s0 / ( max(y_s0)- min(y_s0) )
y_h = y_h0/( max(y_h0)- min(y_h0) )



# %%
length = len(y_s) / Fs_solid
time = np.linspace(0., length, num = len(y_s))
fig, axs = plt.subplots()
fig.suptitle('Solid an  d Hollow signal')
axs.plot(time, y_s)
# axs[1].plot(time, y_h)
plt.show()
# %%
Fs = Fs_hollow
T = 1/Fs
L = len(y_s)
w_k =  np.kaiser(L, 20)
np.dot(y_s, w_k)
Y_H = fft(y_s * w_k ) 
Y_S = fft(y_h * w_k )


# %%
P2H = abs(Y_H/L)
P1H = P2H[1:int(L/2+1)]
P1H[2:-1] = 2*P1H[2:-1]

P2S = abs(Y_S/L)
P1S = P2S[1:int(L/2+1)]
P1S[2:-1] = 2*P1S[2:-1]

f = Fs * np.arange(0,L/2,1) / L



# %%

fig, axs = plt.subplots(2)
fig.suptitle('Solid and Hollow signal')
axs[0].plot(f, P1H)
axs[1].plot(f, P1S)

# %%
print(np.sum(P1H[2000:-1]*P1H[2000:-1])*10000)
print(np.sum(P1S[2000:-1]*P1S[2000:-1])*10000)

# %%



