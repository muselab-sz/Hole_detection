'''
Description: 
Author: hecai
Date: 2022-05-27 16:36:39
LastEditTime: 2022-05-27 16:51:48
FilePath: \raspberrypi\pwm.py
'''
import RPi.GPIO as gpio
import time
R = 18
gpio.setwarnings(False)#屏蔽警告
gpio.setmode(gpio.BCM)#设置引脚模式BCM
gpio.setup(R,gpio.OUT)#设置引脚11方向输出
PR = gpio.PWM(R,400)
PR.start(0)
try:                 #try和except是一对，通过它来捕捉在执行while 1的时候，是否按下了ctrl+c按键，crtl+c是终止程序
   while 1:
       PR.ChangeDutyCycle(20)
       time.sleep(0.5)
       PR.ChangeDutyCycle(22)
       time.sleep(0.5)
except KeyboardInterrupt:     #如果按下了ctrl+c进行异常处理，让pwm停止，释放引脚
    PR.stop()
    gpio.cleanup()   