# AgentOps - OpenCode Configuration

Shared OpenCode configuration for the team including MCP servers, plugins, skills, and custom agents.

## Quick Setup

```bash
git clone git@github.com:minitap-ai/agent-ops.git
cd agent-ops
opencode
```

Then type `/check-update` - this single command handles everything:
- Creates missing directories
- Copies config, skills, and commands to your global config
- Shows what's different and offers to sync
- Prompts you to fill in API keys

## Available Commands

Run these from the agent-ops directory:

| Command | Description |
|---------|-------------|
| `/check-update` | Check & sync your config with this repo (setup, skills, commands, MCPs) |
| `/list-skills` | List all available skills by scope |

## What's Included

### Plugins
- `@tarquinen/opencode-dcp@latest` - Dynamic Context Pruning
- `@zenobius/opencode-skillful` - Skills management

### MCP Servers
- **notion-mcp** - Notion integration (OAuth)
- **github-mcp-server** - GitHub operations
- **context7** - Library documentation
- **supabase** - Supabase database operations (OAuth)

### Skills
- **frontend-design** - Production-grade frontend interfaces
- **mcp-builder** - Build MCP servers
- **skill-creator** - Create new skills

### Custom Agents
- **code** - Autonomous coding agent
- **discuss** - General-purpose assistant

## API Keys

After running `/check-update`, fill in your API keys:

```bash
vim +22 ~/.config/opencode/opencode.json
```

| Placeholder | Line | How to Get |
|-------------|------|------------|
| `YOUR_GITHUB_TOKEN_HERE` | 22 | [GitHub Tokens](https://github.com/settings/tokens) |
| `YOUR_CONTEXT7_KEY_HERE` | 30 | [Context7](https://context7.com) |
