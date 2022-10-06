#! /usr/bin/env bash
pamixer --toggle-mute
#if [ $(pamixer --get-mute) = "true" ]; then
#	echo 0 >> /tmp/xobpipe
#else
#	echo $(pamixer --get-volume) >> /tmp/xobpipe
#fi
