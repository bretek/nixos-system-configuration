#!/usr/bin/env bash
# Use wf-recorder (Wayland screen recorder) in a Rofi prompt

# CONFIG
SAVE_DIR=$(xdg-user-dir)/Videos/Captures
# END CONFIG

pkill wf-recorder
ret_code=$?
pkill -RTMIN+5 waybar
if [ $ret_code == 0 ]; then
    exit 0
fi

notify-send "Recording started"

filename="$(date '+%Y%m%d_%H%M%S').mp4"
mkdir -p $SAVE_DIR
filepath="$SAVE_DIR/$filename"

wf-recorder& -c libx264rgb -f $filepath
pkill -RTMIN+5 waybar

wait

notify-send "Video saved as $filename"
pkill -RTMIN+5 waybar
