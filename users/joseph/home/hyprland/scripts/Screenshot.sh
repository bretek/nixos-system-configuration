#!/usr/bin/env bash

# CONFIG
SAVE_DIR=$(xdg-user-dir)/Pictures/Screenshots
# END CONFIG

# LANGUAGE STRINGS
lang_scr_whole="󰄀 Screenshot whole screen"
lang_scr_fragment="󰄀 Screenshot selected region"

lang_delay=" Delay:"
lang_nodelay=" Delay: None"

lang_save_png=" Save png"
lang_save_jpeg=" Save jpeg"
lang_copy_clipboard=" Copy to clipboard"

lang_copied="Screenshot copied to clipboard"
lang_saved="Screenshot saved to file"
# END OF LANGUAGE STRINGS

rofi_delay=$(
    printf "%s\n%s 1s\n%s 3s\n%s 5s\n%s 10s\n" \
           "$lang_nodelay" "$lang_delay" "$lang_delay" "$lang_delay" "$lang_delay" |
    rofi -dmenu -p "screenshot" -lines 5
) || exit 2

rofi_save_method=$(
    printf "%s\n%s\n%s\n" "$lang_save_png" "$lang_save_jpeg" "$lang_copy_clipboard" |
    rofi -dmenu -p "screenshot" -lines 3
) || exit 3

rofi_scr_type=$(
    printf "%s\n%s\n" "$lang_scr_whole" "$lang_scr_fragment" |
    rofi -dmenu -p "screenshot" -lines 2
) || exit 4

if [ "$rofi_delay" = "$lang_delay 1s" ]; then
    sleep 1
elif [ "$rofi_delay" = "$lang_delay 3s" ]; then
    sleep 3
elif [ "$rofi_delay" = "$lang_delay 5s" ]; then
    sleep 5
elif [ "$rofi_delay" = "$lang_delay 10s" ]; then
    sleep 10
fi

if [ "$rofi_save_method" = "$lang_copy_clipboard" ]; then
    grimblast_command="copy"
else
    grimblast_command="copysave"
fi

if [ "$rofi_save_method" = "$lang_save_jpeg" ]; then
    grimblast_format="jpeg"
else
    grimblast_format="png"
fi

if [ "$rofi_scr_type" = "$lang_scr_fragment" ]; then
    grimblast_target="area"
else
    grimblast_target="output"
fi

filename="$(date '+%Y%m%d_%H%M%S')"
mkdir -p $SAVE_DIR
filepath="$SAVE_DIR/$filename.$grimblast_format"

grimblast --notify --filetype $grimblast_format $grimblast_command $grimblast_target $filepath
