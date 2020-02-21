#!/usr/bin/env python3

import subprocess
import re
import RPi.GPIO as GPIO
from time import sleep

GPIO.setmode(GPIO.BCM)
sysJobTargets = subprocess.check_output(["sudo", "systemctl", "list-jobs"]).decode('utf-8')
if re.search('reboot.target.*start', sysJobTargets) == None:
    GPIO.setup(17, GPIO.OUT)
    GPIO.output(17, GPIO.LOW)
    sleep(30)
