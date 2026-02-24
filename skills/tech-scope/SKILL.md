---
name: tech-scope
description: Generate well-structured implementation tickets from a Notion spec and create them as Notion pages. Use this skill when the user asks to tech scope a feature, a stream, or a Notion spec — producing actionable tickets per repository with story point estimates, TODOs, and dependency wiring.
---

# Tech Scope: Notion Spec → Implementation Tickets

## Overview

Transforms a technical specification (from Notion or web sources) into actionable, well-structured implementation tickets created directly in Notion. One ticket per repository task, with estimates, dependency chains, and full metadata.

## Workflow

Follow these four phases strictly.

---

## Phase 1: Context Gathering & Validation

1. **Source Retrieval:**
   - If the user provides a **Notion link**, use the Notion MCP tools (`notion-fetch`, `notion-search`) to retrieve the spec.
   - **Constraint:** If Notion MCP is unavailable, abort and instruct the user to install it.
   - If the spec references **external web sources**, browse them first to build full technical context.

2. **Environment Analysis:**
   - Explore the available repositories in the workspace to understand the codebase structure relevant to the request.
   - **Abort** if the repositories referenced in the scoping ticket's "Repository" property are not available in the workspace. Ask the user to provide them.

---

## Phase 2: Tech Scoping & Markdown Draft Generation

1. **Ticket Architecture:**
   - For each impacted repository, create a local folder named `TS_<STREAM_NAME>` (stream name in UPPER_CASE).
   - Inside, generate one `.md` file per required task.

2. **Content Standard:** Concise but unambiguous. No high-level fluff — focus on actionable implementation details.
   - `[Estimation]`: Assign a **Fibonacci Story Point** (1, 2, 3, 5, 8). *5 points ≈ 4 hours (one morning or afternoon).*
   - `## Description`: Clear summary of the change + flow diagram if applicable.
   - `## TODO`: Checklist of specific technical steps and components.
   - `## References`: Relevant links from the spec or related documentation.

3. **Draft Review:** Present the markdown drafts to the user for review and refinement. **Wait for explicit confirmation before proceeding to Phase 3.**

---

## Phase 3: Metadata Mapping (Notion Relations)

Before creating tickets in Notion, resolve these three properties by querying the specific Database IDs:

1. **Sprint:**
   - Check the current tech scoping ticket's sprint ($Sprint_X$). Propose $Sprint_{X+1}$.
   - If no sprint is found, retrieve items from the **Sprint DB** (`22dcf438d3ea8035bbf2e57c7675d691`) and ask the user to choose.

2. **Stream:**
   - Identify the "Stream" linked to the original tech scoping ticket.
   - If missing, fetch streams from the **Stream DB** (`22fcf438d3ea80ccafdddcfa6584f1f2`) and ask the user to select.

3. **Repository:**
   - Map each impacted repository to an entry in the **Repository Status DB** (`22dcf438d3ea804aae84f0b336b0b25c`).
   - Flag any repository not found in this database before proceeding.

---

## Phase 4: Final Execution

Once the user confirms drafts and metadata:

1. **Create Tickets:** Use the Notion MCP `notion-create-pages` tool with `data_source_id` as the parent type.

2. **Strict Output:** Do NOT add introductory text or "Overview" pages. Translate `.md` content directly into the Notion page body.

3. **Properties Serialization (CRITICAL):**
   - **Name**: Plain string
   - **SP**: Number (not string)
   - **Status**: Plain string (e.g., `"Backlog"`)
   - **Priority**: Plain string (e.g., `"P0"`, `"P1"`, `"P2"`, `"P3"`)
   - **Repository**: JSON array string for multi_select (e.g., `"[\"mobile-use-mcp\"]"` or `"[\"maas-api\", \"mobile-use-mcp\"]"`)
   - **Sprint**: Plain URL string for relation (e.g., `"https://www.notion.so/abc123..."`) — **NO** `{{}}` wrapper
   - **Stream**: Plain URL string for relation — **NO** `{{}}` wrapper
   - **Blocked by / Blocking**: JSON array of page URLs (e.g., `"[\"https://www.notion.so/page1\", \"https://www.notion.so/page2\"]"`)

4. **Icon:** Set each page icon to `/icons/checkmark_green.svg`.

5. **Dependencies:** Wire `Blocked by` relations between tickets that have logical dependencies (e.g., a middleware ticket blocked by a server setup ticket).

6. **DO NOT** fill the "Assignee" property.

7. **Completion:** Provide a list of clickable Notion links for every ticket created. Note that tickets are created with **Backlog** status — the team should review carefully before moving to **Todo**.
