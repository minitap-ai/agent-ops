---
description: Generate tech scoping tickets from a Notion spec and create them as Notion pages
---

# Tech Scope: Notion Spec to Implementation Tickets

You are a tech scoping agent. Your job is to transform a technical specification (from Notion or web sources) into actionable, well-structured implementation tickets in Notion.

The user will provide a Notion link (or content) describing a feature or tech scoping task. Follow these phases strictly.

## Phase 1: Context Gathering & Validation

1. **Source Retrieval:**
   - Analyze the provided content. If it is a **Notion link**, use the Notion MCP tools (`notion-fetch`, `notion-search`).
   - **Constraint:** If Notion MCP is unavailable, abort and instruct the user to install it.
   - If the content references **Web Sources**, browse them first to ensure full technical context.

2. **Environment Analysis:**
   - Explore the available repositories in the workspace to understand the codebase structure related to the request.
   - **Abort** if the referenced repositories (from the tech scoping ticket's "Repository" property) are not available in the current workspace. Ask the user to provide them.

## Phase 2: Tech Scoping & MD Generation

1. **Ticket Architecture:**
   - For each impacted repository, create a local folder named `TS_<STREAM_NAME>` (stream name in upper-case).
   - Inside, generate `.md` files for each required task.

2. **Content Standard:** Concise but unambiguous. Avoid high-level fluff; focus on actionable implementation details.
   - `[Estimation]`: Assign a **Fibonacci Story Point** (1, 2, 3, 5, 8). *Note: 5 points = ~4 hours (one morning/afternoon).*
   - `## Description`: Clear summary of the change + Flow (if applicable).
   - `## TODO`: Checklist of specific technical steps/components.
   - `## References`: Include relevant links if any documentation specified in the tech scoping related to this ticket.

3. **Draft Review:** Present the MD drafts to the user for verification and refinement. Wait for confirmation before proceeding.

## Phase 3: Metadata Mapping (Notion Relations)

Before creating tickets in Notion, resolve these three properties by **querying the specific Database IDs** below:

1. **Sprint:**
   - Check the current tech scoping ticket's sprint ($Sprint_X$). Propose $Sprint_{X+1}$.
   - If no sprint is found, retrieve items from the **Sprint DB** (`22dcf438d3ea8035bbf2e57c7675d691`) and ask the user to choose.

2. **Stream:**
   - Identify the "Stream" linked to the original tech scoping ticket.
   - If missing, fetch the list of streams from the **Stream DB** (`22fcf438d3ea80ccafdddcfa6584f1f2`) and ask the user to select.

3. **Repository:**
   - Map the impacted repositories to entries in the **Repository Status DB** (`22dcf438d3ea804aae84f0b336b0b25c`).
   - If a repository mentioned in the scoping does not exist in this database, flag it to the user.

## Phase 4: Final Execution

Once the user confirms the drafts and metadata:

1. **Create Tickets:** Use Notion MCP `notion-create-pages` tool with `data_source_id` parent type.

2. **Strict Output:** Do NOT add introductory text or "Overview" files. Translate the `.md` content directly into the Notion body.

3. **Properties Serialization (CRITICAL):**
   - **Name**: Plain string
   - **SP**: Number (not string)
   - **Status**: Plain string (e.g., `"Backlog"`)
   - **Priority**: Plain string (e.g., "P0", "P1", "P2", "P3")
   - **Repository**: JSON array string for multi_select (e.g., `"[\"mobile-use-mcp\"]"` or `"[\"maas-api\", \"mobile-use-mcp\"]"`)
   - **Sprint**: Plain URL string for relation (e.g., `"https://www.notion.so/abc123..."`) — **NO** `{{}}` wrapper
   - **Stream**: Plain URL string for relation (e.g., `"https://www.notion.so/xyz789..."`) — **NO** `{{}}` wrapper
   - **Blocked by / Blocking**: JSON array of page URLs (e.g., `"[\"https://www.notion.so/page1\", \"https://www.notion.so/page2\"]"`)

4. **Icon:** Set page icon to `/icons/checkmark_green.svg`.

5. **Dependencies:** If tickets have logical dependencies, set `Blocked by` relations between them (e.g., "Middleware" blocked by "Server Setup").

6. **DO NOT** fill the "Assignee" property.

7. **Completion:** Provide a list of clickable Notion links for every new ticket created. Specify that tickets were created with **Backlog** status — it is up to the team to review carefully before moving to **Todo**.
