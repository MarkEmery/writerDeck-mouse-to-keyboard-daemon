#!/bin/sh

date > /var/log/mkd
if [ -f /root/writerDeck-mouse-to-keyboard-daemon/bin/python3 ]; then
    device=`cat /root/writerDeck-mouse-to-keyboard-daemon/MOUSE`
    event=`cat /proc/bus/input/devices | egrep -A 2 $device | fgrep event | awk '{print $NF}'`
    echo starting for $device $event >> /var/log/mkd
    /root/writerDeck-mouse-to-keyboard-daemon/bin/python3 /root/writerDeck-mouse-to-keyboard-daemon/evtranslate.py $event >> /var/log/mkd
else
    echo 'Has the directory name been changed? File not found'
fi
