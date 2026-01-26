---
description: List all available OpenCode skills sorted by scope (project, global, Claude-compatible).
---

# Available Skills

## Repository Skills (skills/)
!`ls -1 skills/ 2>/dev/null | while read skill; do if [ -f "skills/$skill/SKILL.md" ]; then desc=$(grep -A1 "^description:" "skills/$skill/SKILL.md" 2>/dev/null | head -1 | sed 's/description: *//'); echo "• $skill - $desc"; fi; done || echo "None"`

## Global Skills (~/.config/opencode/skills/)
!`ls -1 ~/.config/opencode/skills/ 2>/dev/null | while read skill; do if [ -f ~/.config/opencode/skills/$skill/SKILL.md ]; then desc=$(grep -A1 "^description:" ~/.config/opencode/skills/$skill/SKILL.md 2>/dev/null | head -1 | sed 's/description: *//'); echo "• $skill - $desc"; fi; done || echo "None"`

## Project Claude-compatible (.claude/skills/)
!`ls -1 .claude/skills/ 2>/dev/null | while read skill; do if [ -f ".claude/skills/$skill/SKILL.md" ]; then desc=$(grep -A1 "^description:" ".claude/skills/$skill/SKILL.md" 2>/dev/null | head -1 | sed 's/description: *//'); echo "• $skill - $desc"; fi; done || echo "None"`

## Global Claude-compatible (~/.claude/skills/)
!`ls -1 ~/.claude/skills/ 2>/dev/null | while read skill; do if [ -f ~/.claude/skills/$skill/SKILL.md ]; then desc=$(grep -A1 "^description:" ~/.claude/skills/$skill/SKILL.md 2>/dev/null | head -1 | sed 's/description: *//'); echo "• $skill - $desc"; fi; done || echo "None"`

## Your Task

Display the skills above in a clean format. For each skill, show its name and description.
