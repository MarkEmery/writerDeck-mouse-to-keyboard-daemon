#!/bin/sh
### BEGIN INIT INFO
# Provides:          start-mouse-keyboard-daemon.sh
# Required-Start:    
# Required-Stop:
# X-Start-Before:    checkroot
# Default-Start:     S
# Default-Stop:
# X-Interactive:     false
# Short-Description: Starts the daemon to control the keyboard with a mouse.
# Description:       Mouse movement will trigger arrow keys. Held Left click holds
#                    shift down so text can be selected. Release does Ctrl-C copy.
#                    Right click does a Ctrl-V paste.
### END INIT INFO

if [ -f /root/writerDeck-mouse-to-keyboard-daemon/bin/python3 ]; then
    case "$1" in
        stop)
            pkill -f evtranslate.py
            ;;
        start)
            echo 
            /root/writerDeck-mouse-to-keyboard-daemon/bin/python3 /root/writerDeck-mouse-to-keyboard-daemon/evtranslate.py &
            ;;
        status)
            ps -ef | fgrep evtranslate
            ;;
        *)
            echo 'Usage: /etc/init.d/start-mouse-keyboard-daemon.sh {start|status|stop}'
            exit 3
            ;;
    esac
else
    echo 'Has the directory name been changed? File not found'
fi
