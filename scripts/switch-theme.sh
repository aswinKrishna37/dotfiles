#!/bin/bash

theme="$1"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

for ext in jpg jpeg png webp gif; do
    wall="$REPO_DIR/themes/$theme/wallpaper.$ext"
    [ -f "$wall" ] && break
done

if [ ! -f "$wall" ]; then
    echo "Theme not found: $theme"
    exit 1
fi

awww img "$wall" \
    --transition-type grow \
    --transition-duration 0.2

ln -sfn "$REPO_DIR/themes/$theme/waybar" "$HOME/.config/waybar"

pkill waybar
waybar &