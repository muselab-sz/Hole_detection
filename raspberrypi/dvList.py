'''
Description: )
Author: hecai
Date: 2022-05-26 17:30:53
LastEditTime: 2022-05-26 17:34:29
FilePath: \raspberrypi\dvList.py
'''
import pyaudio
po = pyaudio.PyAudio()
for index in range(po.get_device_count()): 
    desc = po.get_device_info_by_index(index)
    #print desc
    print("index:%-5d  maxInputChannels: %-5d  device: %-40s  rate: %-10d" %  (index, desc["maxInputChannels"], desc["name"],  int(desc["defaultSampleRate"])))