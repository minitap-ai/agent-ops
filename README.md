# AgentOps - OpenCode Configuration

Shared OpenCode configuration for the team including MCP servers, plugins, skills, commands, and custom agents.

## Quick Setup

```bash
git clone git@github.com:minitap-ai/agent-ops.git
cd agent-ops
opencode
```

Then type `/check-update` - this single command handles everything:
- Creates missing directories (skills, agents, commands) in your global config, if they don't exist
- Shows what's different and offers to sync (MCP servers, plugins, skills, commands, agents)
- Prompts you to fill in API keys and authenticate MCP servers