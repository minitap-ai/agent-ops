---
description: Check and synchronize your OpenCode configuration with the agent-ops repository. Handles skills, commands, agents, MCP configs, and plugins.
---

# OpenCode Configuration Check

## Repository Reference

@opencode.json

## Current State

### Config Status
!`if [ -f ~/.config/opencode/opencode.json ]; then echo "✓ Config exists"; else echo "✗ No config found"; fi`

### Commands Directory Status
!`if [ -d ~/.config/opencode/commands ]; then echo "✓ Commands directory exists"; else echo "✗ No commands directory"; fi`

### Skills Directory Status
!`if [ -d ~/.config/opencode/skills ]; then echo "✓ Skills directory exists"; else echo "✗ No skills directory"; fi`

### Agents Directory Status
!`if [ -d ~/.config/opencode/agents ]; then echo "✓ Agents directory exists"; else echo "✗ No agents directory"; fi`

### Skills Comparison
!`.opencode/scripts/compare-resource.sh dir skills ~/.config/opencode/skills`

### Commands Comparison
!`.opencode/scripts/compare-resource.sh file commands ~/.config/opencode/commands`

### Agents Comparison
!`.opencode/scripts/compare-resource.sh file agents ~/.config/opencode/agents`

### MCP & Plugins Comparison
!`echo "=== Repository MCP servers ===" && cat opencode.json | grep -A1 '"mcp"' | head -20; echo ""; echo "=== User MCP servers ===" && cat ~/.config/opencode/opencode.json 2>/dev/null | grep -A1 '"mcp"' | head -20 || echo "No config"`

### Config Diff (plugins & mcp structure)
!`if [ -f ~/.config/opencode/opencode.json ]; then echo "=== Plugins ===" && echo "Repo: $(cat opencode.json | grep -o '"plugin".*' | head -1)" && echo "User: $(cat ~/.config/opencode/opencode.json | grep -o '"plugin".*' | head -1)"; fi`

### User Config
!`cat ~/.config/opencode/opencode.json 2>/dev/null || echo "No config file"`

## Your Task

Analyze the state above and act based on what's needed:

### If no config exists
1. Create `~/.config/opencode/` directory
2. Copy `opencode.json` to `~/.config/opencode/opencode.json`

### If no commands directory exists
1. Create `~/.config/opencode/commands/`
2. Copy all commands from `commands/`

### If no skills directory exists
1. Create `~/.config/opencode/skills/`
2. Copy all skills from repository

### If no agents directory exists
1. Create `~/.config/opencode/agents/`
2. Copy all agents from repository

### If skills are missing (✗)
Ask user: "These skills are missing: [list]. Copy them?"

### If commands are missing (✗)
Ask user: "These commands are missing: [list]. Copy them?"

### If agents are missing (✗)
Ask user: "These agents are missing: [list]. Copy them?"

### If skills, commands, or agents differ (⚠)
Show the diff and ask user if they want to update:
!`.opencode/scripts/show-diffs.sh dir skills ~/.config/opencode/skills Skill`
!`.opencode/scripts/show-diffs.sh file commands ~/.config/opencode/commands Command`
!`.opencode/scripts/show-diffs.sh file agents ~/.config/opencode/agents Agent`

### If plugins differ
Compare the `plugin` arrays and offer to update.

### If MCP configs differ
Compare each MCP server config. User may have different API keys - only flag structural differences (missing servers, different URLs).

### Extra skills/commands/agents (•)
Just acknowledge them - these are user-specific.

## Final Step

After any updates, if the config has `YOUR_GITHUB_TOKEN_HERE` or `YOUR_CONTEXT7_KEY_HERE`, tell the user:

```bash
vim +22 ~/.config/opencode/opencode.json
```

And remind about MCP OAuth:
```bash
opencode mcp auth notion-mcp
opencode mcp auth supabase
```
