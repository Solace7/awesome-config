#!/bin/bash

# xwinwrap -g 1920x1200 -ov -ni -nf -b -un -fs -argb -- gifview wtprlmnt.gif -a

# xwinwrap -g 1920x1200 -ov -b -s -fs -st -nf -fdt -- mpv --no-border --no-osc --no-osd-bar --no-input-default-bindings --loop --framedrop=vo --no-audio --panscan=1.0 wtprlmnt.mp4

xwinwrap -g 1920x1200+50 -ov -ni -- mpv --fullscreen --no-stop-screensaver --loop --no-audio --no-border --no-osc --no-osd-bar --no-input-default-bindings wtprlmnt.gif
