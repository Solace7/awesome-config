#!/bin/bash
Xephyr :3 -ac -screen 1280x720 & #1920x1080 &
XEPHYR_PID=$!
sleep 0.5

DISPLAY=:3 awesome -c $HOME/.config/awesome/rc-devel.lua &
instance=$!

while inotifywait -r -e close_write ~/.config/awesome/rc-devel.lua; do
  kill ${XEPHYR_PID}
done
