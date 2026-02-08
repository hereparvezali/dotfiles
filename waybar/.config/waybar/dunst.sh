#!/bin/bash

# Check if Dunst is paused (Do Not Disturb)
IS_PAUSED=$(dunstctl is-paused)
# Check if there are notifications in history
COUNT=$(dunstctl count waiting)
HISTORY=$(dunstctl count history)

ENABLED_ICON="none"
DISABLED_ICON="dnd-none"

if [ "$IS_PAUSED" == "true" ]; then
    if [ "$HISTORY" -gt 0 ]; then
        CLASS="dnd-notification"
    else
        CLASS="dnd-none"
    fi
else
    if [ "$COUNT" -gt 0 ] || [ "$HISTORY" -gt 0 ]; then
        CLASS="notification"
    else
        CLASS="none"
    fi
fi

# Output JSON for Waybar
printf '{"alt":"%s", "class":"%s"}\n' "$CLASS" "$CLASS"
