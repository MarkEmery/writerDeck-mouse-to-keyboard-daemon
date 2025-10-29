
To install the mouse to keyboard code, you'll need to do the following.

Exit Tilde to the shell and get root access, install the software and supporting code.

```
sudo su -
apt update
apt install openssh-server python3-pip git python3.11-venv
git clone https://github.com/MarkEmery/writerDeck-mouse-to-keyboard-daemon
cd writerDeck-mouse-to-keyboard-daemon
./bin/pip3 install evdev keyboard
```
With the mouse plugged in, run lsusb and note the device ID. In the example below it's 30DA:0300.

```
root@writerdeck:/etc/rc5.d# lsusb 
Bus 002 Device 003: ID 5986:0292 Bison Electronics Inc. Lenovo Integrated Webcam
Bus 002 Device 002: ID 0bda:0139 Realtek Semiconductor Corp. RTS5139 Card Reader Controller
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 002: ID 30fa:0300  USB Optical Mouse  <<<<<<<<<<<<<
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
```
Sadly the event handler number for any given device can change from reboot to reboot, so we need the startup script to find it.
To see this for yourself, run the following after each reboot. (Change 30fa:0300 to your unique Device ID)

```
root@writerdeck:~/writerDeck-mouse-to-keyboard-daemon# cat /proc/bus/input/devices | egrep -B 3 -A 3 -i 30fa:0300 
I: Bus=0003 Vendor=30fa Product=0300 Version=0111
N: Name="USB Optical Mouse "
P: Phys=usb-0000:00:12.0-1/input0
S: Sysfs=/devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.0/0003:30FA:0300.0001/input/input4
U: Uniq=
H: Handlers=mouse0 event2 
B: PROP=0
```
In the ~/writerDeck-mouse-to-keyboard-daemon directory, create a file MOUSE and add a single line with your device ID.
Next copy the startup files to the right place.

```
cd ~/writerDeck-mouse-to-keyboard-daemon
vi MOUSE
cp start-mouse-keyboard-daemon.sh /etc/init.d/
ln -s /etc/init.d/start-mouse-keyboard-daemon.sh /etc/rc5.d/S02mkd
chmod +x /etc/rc5.d/S02mkd
```
A reboot should have the daemon start up automatically.
