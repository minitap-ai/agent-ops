---
description: List all available OpenCode skills sorted by scope (project, global, Claude-compatible).
---

# Available Skills

## Repository Skills (skills/)
!`bash -c 'found=0; for d in skills/*/; do [ -d "$d" ] && skill=$(basename "$d") && found=1 && echo "• $skill"; done; [ $found -eq 0 ] && echo "None"'`

## Global Skills (~/.config/opencode/skills/)
!`bash -c 'found=0; for d in ~/.config/opencode/skills/*/; do [ -d "$d" ] && skill=$(basename "$d") && found=1 && echo "• $skill"; done; [ $found -eq 0 ] && echo "None"'`

## Project Claude-compatible (.claude/skills/)
!`bash -c 'found=0; for d in .claude/skills/*/; do [ -d "$d" ] && skill=$(basename "$d") && found=1 && echo "• $skill"; done; [ $found -eq 0 ] && echo "None"'`

## Global Claude-compatible (~/.claude/skills/)
!`bash -c 'found=0; for d in ~/.claude/skills/*/; do [ -d "$d" ] && skill=$(basename "$d") && found=1 && echo "• $skill"; done; [ $found -eq 0 ] && echo "None"'`

## Your Task

Display the skills above in a clean format. For each skill, show its name and description.
