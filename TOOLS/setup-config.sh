#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/../etc/izzyplayer"
TARGET="$HOME/.config/izzyplayer/mpv.conf"

mkdir -p "$HOME/.config/izzyplayer"

detect_platform() {
    if [ -f /proc/device-tree/model ]; then
        MODEL=$(cat /proc/device-tree/model 2>/dev/null)
        if echo "$MODEL" | grep -q "Raspberry Pi"; then
            echo "raspberry"; return
        fi
    fi
    if [ "$(uname)" = "Darwin" ]; then echo "macos"; return; fi
    if [ "$(uname -o 2>/dev/null)" = "Msys" ]; then echo "windows"; return; fi
    echo "default"
}

PLATFORM=$(detect_platform)
echo "IzzyPlayer: Detected platform → $PLATFORM"

cat "$CONFIG_DIR/default.conf" > "$TARGET"
if [ "$PLATFORM" != "default" ] && [ -f "$CONFIG_DIR/$PLATFORM.conf" ]; then
    echo "" >> "$TARGET"
    cat "$CONFIG_DIR/$PLATFORM.conf" >> "$TARGET"
    echo "IzzyPlayer: Config loaded → default.conf + $PLATFORM.conf"
else
    echo "IzzyPlayer: Config loaded → default.conf only"
fi
