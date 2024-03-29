#!/usr/bin/env bash

if [ "$1" == "up" ]; then
    amixer set Master 5%+ >/dev/null 2>&1
elif [ "$1" == "down" ]; then
    amixer set Master 5%- >/dev/null 2>&1
elif [ "$1" == "mute" ]; then
    a=$(amixer set Master 1+ toggle);
elif [ "$1" == "mic" ]; then
    pactl list sources | grep -A12 'Source #1' | grep -qi 'Mute: yes' && pactl set-source-mute 1 0 || pactl set-source-mute 1 1
fi

vpattern=".*\[([0-9]+)%\].*"
spattern=".*\[off\].*"

amixer="amixer -c1"

master=$($amixer sget 'Master')
mic=$($amixer sget 'Capture')

mavol=$(echo $master | grep '%' | sed -r "s/$vpattern/\1/")
mivol=$(echo $mic | grep '%' | sed -r "s/$vpattern/\1/")
mivol=0

jackdev=$($amixer contents | grep -i "'headphone jack'" | cut -d"," -f1,2)

THEME="~/.local/share/icons/$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")"


if grep -qi $spattern <<< $master; then
    icon="🔇"
    ipath="$(find "$THEME" -name *audio*mute* | grep 24 | head -n1)"
elif grep -qi 'values=on' <<< $($amixer cget "$jackdev"); then
    icon="🎧"
    ipath="$(find "$THEME" -name *headphone* | grep 24 | head -n1)"
elif [ $mavol -gt 0 ] && [ $mavol -lt 31 ]; then
    icon="🔈"
    ipath="$(find "$THEME" -name *audio*low* | grep 24 | head -n1)"
elif [ $mavol -gt 30  ] && [ $mavol -lt 60 ]; then
    icon="🔉"
    ipath="$(find "$THEME" -name *audio*medium* | grep 24 | head -n1)"
else
    icon="🔊"
    ipath="$(find "$THEME" -name *audio*high* | grep 24 | head -n1)"
fi

if [ -z $1 ]; then
    printf '%3s\n%3s%%' "$icon" "$mavol"
else
    notify-send -i $ipath "$mavol %"
fi
