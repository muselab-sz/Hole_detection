'''
Description: 
Author: hecai
Date: 2022-05-26 16:36:46
LastEditTime: 2022-05-31 12:39:00
FilePath: \raspberrypi\main.py
'''
import os
import pyaudio
import sys
import matplotlib.pyplot as plt
import numpy as np

CHUNK = 512
FORMAT = pyaudio.paInt16
CHANNELS = 1
RATE = 44100
RECORD_SECONDS = 5
WAVE_OUTPUT_FILENAME = "output.wav"

p = pyaudio.PyAudio()

stream = p.open(format=FORMAT,
                channels=CHANNELS,
                rate=RATE,
                input=True, input_device_index=1,
                frames_per_buffer=CHUNK)

print("* recording")

datas=bytes()
f=int(RATE / CHUNK)
for i in range(0,f):
    data = stream.read(CHUNK)
    datas = datas+data
frames = np.frombuffer(datas, dtype=np.uint8).astype(np.float)
y_h=frames/(max(frames)-min(frames))
length = len(y_h) / RATE
time = np.linspace(0., length, num = len(y_h))
fig, axs = plt.subplots(1)
fig.suptitle('Solid an  d Hollow signal')
axs.plot(time, y_h)
plt.savefig("./test.jpg")
print("* done recording")

stream.stop_stream()
stream.close()
p.terminate()

# wf_path = os.path.join(sys.path[0], WAVE_OUTPUT_FILENAME)
# wf = wave.open(wf_path, 'wb')
# wf.setnchannels(CHANNELS)
# wf.setsampwidth(p.get_sample_size(FORMAT))
# wf.setframerate(RATE)
# wf.writeframes(b''.join(frames))
# wf.close()
# print(wf_path)