To install the mouse to keyboard code, you'll need to do the following.

Exit Tilde to the shell and get root access to install the software and supporting code.

```
sudo su -
apt update
apt install openssh-server python3-pip git python3.11-venv
git clone https://github.com/MarkEmery/writerDeck-mouse-to-keyboard-daemon
cd writerDeck-mouse-to-keyboard-daemon
./bin/pip3 install evdev keyboard
```
Now we need to find the event handler for our mouse. WITHOUT the mouse plugged in, check which events are returned.

```
root@writerdeck:~/writerDeck-mouse-to-keyboard-daemon# cat /proc/bus/input/devices | egrep -B 3 -A 3 mouse
P: Phys=isa0060/serio1/input0
S: Sysfs=/devices/platform/i8042/serio1/input/input3
U: Uniq=
H: Handlers=mouse0 event2 
B: PROP=9
B: EV=b
B: KEY=6420 30000 0 0 0 0
```
Now plug the mouse in and run the command again. The mouse will be the newly added entry. Note the event number. In this example it's 14.

```
root@writerdeck:~/writerDeck-mouse-to-keyboard-daemon# cat /proc/bus/input/devices | egrep -B 3 -A 3 mouse
P: Phys=isa0060/serio1/input0
S: Sysfs=/devices/platform/i8042/serio1/input/input3
U: Uniq=
H: Handlers=mouse0 event2 
B: PROP=9
B: EV=b
B: KEY=6420 30000 0 0 0 0
--
P: Phys=usb-0000:00:12.0-1/input0
S: Sysfs=/devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.0/0003:30FA:0300.0003/input/input17
U: Uniq=
H: Handlers=mouse1 event14 
B: PROP=0
B: EV=17
B: KEY=1f0000 0 0 0 0
```

Edit the python script to make reference to the correct event number, then copy the startup files to the right place.

```
cd ~/writerDeck-mouse-to-keyboard-daemon
cp start-mouse-keyboard-daemon.sh /etc/init.d/
ln -s /etc/init.d/start-mouse-keyboard-daemon.sh /etc/rc5.d/
chmod +x /etc/rc5.d/start-mouse-keyboard-daemon.sh
```

A reboot should have the daemon start up automatically.



