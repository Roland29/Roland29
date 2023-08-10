#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title ngrok-copy
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Copy ngrok url to clipboard
# @raycast.author Roland PAIRE
# @raycast.authorURL https://github.com/Roland29

# Copy the url of the active ngrok connection to the clipboard.
# Usage:
#   ngrok-copy     # copies e.g. https://3cd67858.ngrok.io to clipboard.
#   ngrok-copy -u  # copies e.g. http://3cd67858.ngrok.io to clipboard.

if [[ "$1" == "-u" ]]; then
    NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep "https://.*.ngrok-free.app"  -oh)
else
    NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep "https://.*.ngrok-free.app"  -oh)
fi

if [[ $NGROK_URL != *"http"* ]]; then
    echo "No url found. Is ngrok running?"
    exit 1
fi

if [ "$(uname)" == "Darwin" ]; then
    # OSX
    echo "$NGROK_URL" | pbcopy
else
    # Linux
    echo "$NGROK_URL" | xclip -selection clipboard
fi
echo "Copied to clipboard: $NGROK_URL"

