#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

theme=$(find "$REPO_DIR/themes" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort |
    rofi -dmenu -p "Select Theme")

[ -n "$theme" ] && "$SCRIPT_DIR/switch-theme.sh" "$theme"

