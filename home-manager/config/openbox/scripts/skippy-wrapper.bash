#!/bin/bash

#
# skippy-wrapper - B. Murphy
#
# a work around for the bug in skippy-xd that prevents minimized
# windows being included in the selection screen.
#
# dependency: xdotool
#

#
# prelim -- check not already running
# 0. get desktop
# 1. get list of all windows
# 2. get list of visible windows
# 3  generate list of hidden windows 
# 4. raise hidden windows
# 5. run skippy-xd
# 6. get active window = SkippySelected
# 7. minimize hidden windows unless selected
#

#prelim
#if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then exit; fi

#0.
dtop=`xdotool get_desktop`

#1.
any=`xdotool search --desktop $dtop "" 2> /dev/null`

#2.
visible=`xdotool search --desktop $dtop --onlyvisible "" 2> /dev/null`

#3.
hidden=$any
for item in $visible; do
    hidden=`echo ${hidden/$item/''}`
done

#4.
for item in $hidden; do
  xdotool windowmap $item
done

#5.
skippy-xd &> /dev/null

#6.
SkippySelected=`xdotool getactivewindow`

#7.
hidden=`echo ${hidden/$SkippySelected/''}`
for item in $hidden; do
  xdotool windowminimize $item
done
