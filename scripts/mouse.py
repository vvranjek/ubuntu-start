#! /usr/bin/env python3


# On Ubuntu install
# sudo apt install python3 python3-pip python3-tk
# pip3 install pyautogui




#from autopilot.input import Mouse
import time
import random
import pyautogui
import sys
import datetime

timeout = float(sys.argv[1])
print("Timeout: %s" % timeout)
ts = time.time()

endtime = (ts + (timeout*60))

print("Setting timer for %s minutes (%ss)." % (timeout, (timeout*60)))


x = 100
y = 100

while True:
    pyautogui.moveTo(random.randint(1920, 1920), random.randint(300, 800), duration=0.5)
    pyautogui.click()

    time.sleep(30)

    if time.time() > endtime:
        print("Exiting")
        exit(0)
