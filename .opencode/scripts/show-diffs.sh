#!/bin/bash
# Show detailed diffs between repo and user's global config
# Usage: show-diffs.sh <type> <repo_path> <user_path> <label>
# Types: dir (for skills), file (for commands, agents)

TYPE=$1
REPO_PATH=$2
USER_PATH=$3
LABEL=$4

if [ -z "$TYPE" ] || [ -z "$REPO_PATH" ] || [ -z "$USER_PATH" ]; then
    echo "Usage: $0 <dir|file> <repo_path> <user_path> [label]"
    exit 1
fi

LABEL=${LABEL:-"Item"}

if [ "$TYPE" = "dir" ]; then
    # For directories (skills)
    for item in $(ls -1 "$REPO_PATH" 2>/dev/null); do
        if [ -d "$USER_PATH/$item" ]; then
            diff_output=$(diff -r "$REPO_PATH/$item" "$USER_PATH/$item" 2>/dev/null)
            if [ -n "$diff_output" ]; then
                echo "=== $LABEL: $item ==="
                echo "$diff_output"
                echo ""
            fi
        fi
    done
else
    # For files (commands, agents)
    for item in $(ls -1 "$REPO_PATH"/*.md 2>/dev/null | xargs -n1 basename); do
        if [ -f "$USER_PATH/$item" ]; then
            diff_output=$(diff "$REPO_PATH/$item" "$USER_PATH/$item" 2>/dev/null)
            if [ -n "$diff_output" ]; then
                echo "=== $LABEL: $item ==="
                echo "$diff_output"
                echo ""
            fi
        fi
    done
fi
