#!/bin/bash
# Compare resources between repo and user's global config
# Usage: compare-resource.sh <type> <repo_path> <user_path>
# Types: dir (for skills), file (for commands, agents)

TYPE=$1
REPO_PATH=$2
USER_PATH=$3

if [ -z "$TYPE" ] || [ -z "$REPO_PATH" ] || [ -z "$USER_PATH" ]; then
    echo "Usage: $0 <dir|file> <repo_path> <user_path>"
    exit 1
fi

echo "=== Status ==="

if [ "$TYPE" = "dir" ]; then
    # For directories (skills)
    for item in $(ls -1 "$REPO_PATH" 2>/dev/null); do
        if [ -d "$USER_PATH/$item" ]; then
            if diff -rq "$REPO_PATH/$item" "$USER_PATH/$item" >/dev/null 2>&1; then
                echo "✓ $item"
            else
                echo "⚠ $item (differs)"
            fi
        else
            echo "✗ $item (missing)"
        fi
    done
else
    # For files (commands, agents)
    for item in $(ls -1 "$REPO_PATH"/*.md 2>/dev/null | xargs -n1 basename); do
        if [ -f "$USER_PATH/$item" ]; then
            if diff -q "$REPO_PATH/$item" "$USER_PATH/$item" >/dev/null 2>&1; then
                echo "✓ $item"
            else
                echo "⚠ $item (differs)"
            fi
        else
            echo "✗ $item (missing)"
        fi
    done
fi

echo ""
echo "=== Extra (user-specific) ==="

if [ "$TYPE" = "dir" ]; then
    for item in $(ls -1 "$USER_PATH" 2>/dev/null); do
        if [ ! -d "$REPO_PATH/$item" ]; then
            echo "• $item"
        fi
    done
else
    for item in $(ls -1 "$USER_PATH"/*.md 2>/dev/null | xargs -n1 basename); do
        if [ ! -f "$REPO_PATH/$item" ]; then
            echo "• $item"
        fi
    done
fi
