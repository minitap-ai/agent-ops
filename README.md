# AgentOps - OpenCode Configuration

Shared OpenCode configuration for the team including MCP servers, plugins, skills, and custom agents.

## Quick Setup

```bash
git clone git@github.com:minitap-ai/agent-ops.git
cd agent-ops
opencode
```

Then type `/check-update` - this single command handles everything:
- Creates missing directories (skills, agents, commands)
- Shows what's different and offers to sync
- Prompts you to fill in API keys and authenticate MCP servers