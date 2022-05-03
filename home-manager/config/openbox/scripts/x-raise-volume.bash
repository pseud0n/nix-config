#! /usr/bin/env bash
pamixer --unmute
pamixer --increase 5
echo $(pamixer --get-volume) >> /tmp/xobpipe
