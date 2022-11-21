'''
Description: 
Author: hecai
Date: 2022-05-31 14:51:21
LastEditTime: 2022-05-31 17:58:57
FilePath: \raspberrypi\seri.py
'''

import serial
from time import sleep
 
ser = serial.Serial ("/dev/ttyS0", 9600)    #Open port with baud rate
while True:
    received_data = ser.read()              #read serial port
    sleep(0.03)
    data_left = ser.inWaiting()             #check for remaining byte
    received_data += ser.read(data_left)
    print (received_data)                   #print received data
    while True:
        a="5500020509080100ffffffffffff05"
        a_bytes = bytes.fromhex(a)
        ser.write(a_bytes)
        
        received_data = ser.read()              #read serial port
        sleep(0.03)
        data_left = ser.inWaiting()             #check for remaining byte
        received_data += ser.read(data_left)
        if len(received_data)<10:
            print("card out")
            break
        sleep(0.2)