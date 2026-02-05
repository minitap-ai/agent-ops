---
description: Prepare and create a PR with optimized commit history for easy review
---

# Prepare Pull Request

You are preparing a pull request for code review. Your goal is to make the reviewer's experience as smooth as possible by organizing commits logically.

## Step 1: Commit Uncommitted Changes

First, check for any uncommitted changes:
```bash
git status
```

If there are uncommitted changes (staged or unstaged):
- Commit them using conventional commit format: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`
- Use atomic commits - one logical change per commit
- Write clear commit messages that explain WHY, not just WHAT

## Step 2: Analyze Commit History

Look at ALL commits since the branch diverged from main:
```bash
git log $(git merge-base HEAD main)..HEAD --oneline
git diff $(git merge-base HEAD main)..HEAD --stat
```

Evaluate if commits need reorganization:
- Are commits atomic (one responsibility each)?
- Do they follow a logical narrative?
- Are related changes grouped together?
- Can a reviewer understand the feature by reading commits in order?

## Step 3: Clean Up Commits (only if needed)

**IMPORTANT: Prefer keeping the existing commit history!** Only reorganize if the history is genuinely messy and hard to review. A few imperfect commits are fine - don't over-engineer.

### If history is fine (most cases)
Keep it as-is. Move to Step 4.

### If small fixes are needed
Use **fixup commits** with non-interactive rebase to keep it clean:

```bash
# Make your fix, then create a fixup commit targeting the original
git commit --fixup=<commit-hash-to-fix>

# Squash fixups automatically (non-interactive)
GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash $(git merge-base HEAD main)
```

### If history is truly messy (rare)
Only do a full reorganization if commits are chaotic and impossible to review:

1. **Create backup first:**
   ```bash
   git branch backup-$(date +%s)
   ```

2. **Soft reset to merge-base:**
   ```bash
   git reset --soft $(git merge-base HEAD main)
   ```

3. **Recommit in logical order** using conventional commits.

**CRITICAL: You MUST NOT destroy any work. All code changes must be preserved. Only the commit organization changes.**

## Step 4: Run Quality Checks

Before creating the PR, ensure all quality checks pass. Look for project-specific commands in `package.json`, `Makefile`, `pyproject.toml`, or similar config files.

Common patterns:
- **Lint:** `lint`, `check`, `eslint`, `ruff check`, `flake8`
- **Test:** `test`, `pytest`, `jest`, `vitest`
- **Format:** `format`, `fmt`, `prettier`, `ruff format`, `black`

**If any checks fail:**
1. Fix the issues
2. Fixup the appropriate commit (see Step 3)
3. Re-run checks until all pass

**CRITICAL: Do NOT create a PR if lint, test, or format checks are failing.**

## Step 5: Create the Pull Request

1. Push the branch (use `--force-with-lease` if history was rewritten):
   ```bash
   git push -u origin <branch-name> --force-with-lease
   ```

2. Create PR using GitHub MCP with:
   - Conventional commit style title (`feat:`, `fix:`, `refactor:`, etc.)
   - Clear summary of changes

## Step 6: Report to User

Provide the PR link and explain concisely:
- That you've prepared the PR with an optimized commit history for easy review
- The logical order you chose for the commits (e.g., "1. Core model, 2. Service layer, 3. API endpoints, 4. Tests")
- Keep it brief - focus on the reviewer experience
