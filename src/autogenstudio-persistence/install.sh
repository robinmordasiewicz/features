#!/usr/bin/env bash
#

set -e

# Define the target and the link locations
TARGET_FILE="/workspaces/autogenstudio/dbdefaults.json"
SEARCH_PATH="/usr/local/lib"
FILENAME="dbdefaults.json"

# Create the symbolic link
find "$SEARCH_PATH" -type f -name "$FILENAME" -exec sh -c 'rm -f "$1" && ln -s "$2" "$1"' _ {} "$TARGET_FILE" \;
