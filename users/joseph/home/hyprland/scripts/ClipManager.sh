#!/usr/bin/env bash

while true; do
mapfile -t BINDINGS < <(cliphist list)

CHOICE=$(
    printf '%s\n' "${BINDINGS[@]}" | rofi -i -dmenu \
        -kb-custom-1 "Control-Delete" \
        -kb-custom-2 "Alt-Delete" \
        -p "Copy" \
        -mesg "Ctrl+Del: delete entry, Alt+Del: clear history"
)

case "$?" in
    1)
        exit
        ;;
    0)
        case "$CHOICE" in
            "")
                continue
                ;;
            *)
                cliphist decode <<<"$CHOICE" | wl-copy
                exit
                ;;
        esac
        ;;
    10)
        cliphist delete <<<"$CHOICE"
        ;;
    11)
        cliphist wipe
        ;;
esac
done
