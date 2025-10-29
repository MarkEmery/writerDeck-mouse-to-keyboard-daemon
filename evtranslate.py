# pip3 install evdev keyboard

import os
import sys
import keyboard

from evdev import InputDevice, ecodes, categorize

left = 0
right = 0
x = 0
y = 0
max = 40

# Replace eventX with your device's event file
device_path = '/dev/input/' + sys.argv[1]

try:
    device = InputDevice(device_path)
    print(f"Listening for mouse events on {device.name}...")

    for event in device.read_loop():
        # Check for relative motion events (REL_X, REL_Y)
        if event.type == ecodes.EV_REL:
            if event.code == ecodes.REL_X:
                x = x + event.value
                if x > max:
                    x = 0
                    keyboard.send('right')
                if x < -max:
                    x = 0
                    keyboard.send('left')
            if event.code == ecodes.REL_Y:
                y = y + event.value
                if y > max:
                    y = 0
                    keyboard.send('down')
                if y < -max:
                    y = 0
                    keyboard.send('up')
        if event.type == ecodes.EV_KEY:
            if event.code == ecodes.BTN_LEFT:
               state = event.value
               if state == 1:
                  keyboard.press('shift')
               if state == 0:
                  keyboard.release('shift')
                  keyboard.send('ctrl+c')
        if event.type == ecodes.EV_KEY:
            if event.code == ecodes.BTN_RIGHT:
               # print(f"Button: {categorize(event)}")
               state = event.value
               if state == 1:
                  keyboard.send('ctrl+v')

except FileNotFoundError:
    print(f"Error: Device file '{device_path}' not found.")
    print("Please run 'cat /proc/bus/input/devices' to find the correct event file.")
except PermissionError:
    print("Error: Permission denied. Try running the script with sudo.")
    sys.exit(1)

