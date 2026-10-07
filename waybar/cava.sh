#!/bin/bash

frames=(
    "▂▅▄"
    "▃▆▅"
    "▄▇▆"
    "▅▆▇"
    "▆▅▆"
    "▇▄▅"
    "▆▃▄"
    "▅▂▃"
    "▄▃▂"
    "▃▄▃"
    "▂▅▄"
)

i=0
max_length=35

while true; do
    player=""

    # Find the first currently playing MPRIS player
    while read -r p; do
        if [ "$(playerctl -p "$p" status 2>/dev/null)" = "Playing" ]; then
            player="$p"
            break
        fi
    done < <(playerctl -l 2>/dev/null)

    if [ -n "$player" ]; then

        title=$(playerctl -p "$player" metadata \
            --format '{{artist}} - {{title}}' 2>/dev/null)

        if [ ${#title} -gt $max_length ]; then
            title="${title:0:$((max_length - 3))}..."
        fi

        printf '{"text":"%s %s","class":"playing"}\n' \
            "${frames[$i]}" "$title"

        i=$(( (i + 1) % ${#frames[@]} ))

        sleep 0.25

    else
        printf '{"text":"","class":"stopped"}\n'
        sleep 1
    fi
done