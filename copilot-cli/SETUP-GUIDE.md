# Setting Up Persistent Copilot CLI Instructions

This guide explains how to set up a personal, portable Copilot CLI instructions file that persists across sessions, syncs across machines, and gives Copilot deep context about how you work.

## Why

By default, Copilot CLI starts every session with no memory of your preferences, conventions, or projects. You end up repeating the same context every time.

A persistent instructions file solves this. Copilot CLI automatically reads `~/.copilot/copilot-instructions.md` at the start of every session. By maintaining this file in a private Git repo and symlinking it into place, you get:

- **Session continuity** — Copilot knows your tools, repos, coding style, and conventions without being told each time.
- **Cross-machine sync** — Pull the repo on any device and your instructions follow you.
- **Version history** — Git tracks every change, so you can review how your instructions evolved.
- **Separation of concerns** — Your personal instructions stay in your private repo, separate from any per-repo `.github/copilot-instructions.md` files.

## How It Works

Copilot CLI loads instructions from two sources:

1. **Global instructions** — `~/.copilot/copilot-instructions.md` (applies to every session)
2. **Repo instructions** — `.github/copilot-instructions.md` in the current repo (applies only in that repo)

Both are loaded together. This guide sets up the global file.

## Setup

### 1. Choose Your Clone Location

Decide where you want to keep local Git clones on this machine. Common choices:

| OS | Typical paths |
|----|---------------|
| Windows | `C:\Users\you\src`, `C:\GitHub`, `D:\GitHub`, `%USERPROFILE%\repos` |
| macOS | `~/src`, `~/Developer`, `~/GitHub` |
| Linux | `~/src`, `~/repos`, `~/GitHub` |

Pick a path and use it consistently. The rest of this guide uses **`<repos>`** as a placeholder for your chosen location (e.g., `~/src` or `D:\GitHub`).

> **Tip:** Add your clone location to your instructions file (under **Development Environment → Source code location**) so Copilot always knows where to find your repos without asking.

### 2. Create a Private GitHub Repo

Create a private repo to store your instructions. This keeps your preferences, org structure, and workflow details private.

```powershell
# On GitHub — create a private repo (e.g., your-username/copilot-instructions)
gh repo create copilot-instructions --private --clone -- <repos>/copilot-instructions
cd <repos>/copilot-instructions
```

### 3. Create Your Instructions File

Create `copilot-instructions.md` in the repo root. Start simple and grow it over time:

```markdown
# Copilot Instructions

## About Me

- Name: [Your Name]
- Role: [Your Role]
- Primary languages: [e.g., TypeScript, Python, YAML]

## Development Environment

- Shell: [e.g., PowerShell 7, zsh, bash]
- Editor: VS Code
- Source code location: [e.g., ~/src, D:\GitHub]

## Preferences

- [Your coding conventions, style preferences, etc.]

## Key Repositories

| Repo | Description |
|------|-------------|
| `org/repo-name` | Brief description |

## Guardrails

- [Things Copilot should never do in your environment]
```

### 4. Symlink Into Copilot's Config Directory

Copilot CLI reads from `~/.copilot/copilot-instructions.md`. Create a symlink so it always picks up the latest from your repo.

Replace `<repos>` below with the path you chose in step 1.

**Windows (PowerShell — run as Administrator):**

```powershell
# Remove existing file if present
Remove-Item "$HOME\.copilot\copilot-instructions.md" -Force -ErrorAction SilentlyContinue

# Create symlink
New-Item -ItemType SymbolicLink `
  -Path "$HOME\.copilot\copilot-instructions.md" `
  -Target "<repos>\copilot-instructions\copilot-instructions.md"
```

**macOS / Linux:**

```bash
# Remove existing file if present
rm -f ~/.copilot/copilot-instructions.md

# Create symlink
ln -s <repos>/copilot-instructions/copilot-instructions.md ~/.copilot/copilot-instructions.md
```

### 5. Verify

Start a new Copilot CLI session and ask "What do you know about me?" — it should reflect your instructions.

## Syncing Across Machines

On a new machine:

```powershell
# Clone your instructions repo (replace <repos> with your chosen location)
git clone https://github.com/your-username/copilot-instructions.git <repos>/copilot-instructions

# Create the symlink (see step 4 above)
```

To pull updates from another machine:

```powershell
cd <repos>/copilot-instructions
git pull
# Changes take effect immediately — the symlink means Copilot reads the file directly
```

To push changes made during a session:

```powershell
cd <repos>/copilot-instructions
git add -A && git commit -m "Update instructions" && git push
```

> **Tip:** You can ask Copilot itself to update your instructions during a session. Just say "remember that I prefer X" or "add this to our instructions" and it can edit the file and push for you.

### Multi-Device Safety

If you use Copilot on multiple machines, there's an important risk: **Copilot edits the local file without checking if the remote has newer changes.** This means work you did on another device can be silently overwritten.

To prevent this, add a rule to your instructions file telling Copilot to sync before and after any edit. Here's a template you can adapt:

```markdown
### Editing instructions (multi-device safety)

This file may be edited from multiple devices. To avoid overwriting changes made
on another device, always follow this workflow before and after any edit to this file:

**Before editing:**
1. `cd <repos>/copilot-instructions`
2. `git fetch origin`
3. Check for divergence: `git log --oneline HEAD..origin/main`
   - If there are incoming commits, run `git pull --rebase` first.
   - If the pull introduces a merge conflict, stop and ask the user — do not auto-resolve.

**After editing:**
1. `git add -A && git commit -m "<descriptive message>"`
2. `git push`
   - If the push is rejected (remote has new commits), run `git pull --rebase` and retry.
   - If the rebase introduces a conflict, stop and ask the user.
```

**Why this matters:** Without this rule, Copilot has no awareness that the file might be stale. It will happily edit whatever is on disk — even if you pushed changes from your laptop an hour ago and this desktop hasn't pulled yet. The push-after-edit step also ensures your other devices can pick up the change immediately.

**What can go wrong without this:**

| Scenario | Result |
|----------|--------|
| You edit on Device A, push. Then ask Copilot on Device B to add something. | Device B overwrites Device A's changes locally. Next push from B loses A's work. |
| You edit on two devices without pushing from either. | Both devices diverge from each other. Manual merge needed. |
| Copilot edits but doesn't push. You switch devices. | The edit only exists on one machine. You might forget it's there. |

Adding the sync rule to your instructions ensures Copilot handles this automatically — pull before edit, push after edit, stop on conflict.

## What to Put in Your Instructions

Build your instructions incrementally. After each session, consider: "Did I have to explain something that Copilot should already know?" If so, add it.

### Sections That Work Well

| Section | Purpose | Example |
|---------|---------|---------|
| **About Me** | Role, org, products | "Senior engineer on the Auth team" |
| **Development Environment** | Tools, paths, shell | "PowerShell 7, VS Code, ~/src" |
| **Preferences** | Style, conventions | "Use full cmdlet names, not aliases" |
| **Guardrails** | Things to avoid | "Don't force-push to main" |
| **Key People** | Collaborators and roles | "Alice — tech lead, owns the API" |
| **Key Repositories** | Repos you maintain | Table of repos with descriptions |
| **Reference Links** | Important URLs | Docs, dashboards, wikis |
| **Shortcuts** | Custom trigger words | "standup" → summarize recent activity |
| **Active Projects** | Current focus areas | Conference prep, feature specs |
| **Workflows** | Structured procedures | Step-by-step triage, review, deploy |
| **Conventions** | Technical standards | Regex format, PR templates, commit style |
| **TODOs** | Future work reminders | "Next time in repo X, fix Y" |

### Tips

- **Be specific.** "Use `Get-ChildItem`, not `gci`" is better than "use verbose commands."
- **Include guardrails.** Tell Copilot what NOT to do — it prevents costly mistakes.
- **Add shortcuts.** Define trigger words for common workflows (e.g., "standup", "triage").
- **Document conventions once.** Regex format, PR body structure, commit message style — write them down so Copilot follows them consistently.
- **Track TODOs.** Add reminders like "Next time we work in repo X, remind me to fix Y" — Copilot will surface them at the right moment.
- **Keep it current.** Outdated instructions cause confusion. Update after major workflow changes.

## Privacy Considerations

Your instructions file may contain:

- Internal org structure and reporting chains
- Internal tool URLs (SharePoint, dashboards, etc.)
- Product names and project details
- Names and roles of colleagues

**Keep the repo private.** If you want to share the *pattern* with others, share this guide — not your actual instructions file. Each person's instructions should be tailored to their own role, repos, and preferences.

## Additional Copilot CLI Configuration

Beyond instructions, you may want to configure additional tools:

### MCP Servers

MCP (Model Context Protocol) servers extend Copilot CLI with additional capabilities. Configure them in `~/.copilot/mcp-config.json`:

```json
{
  "mcpServers": {
    "server-name": {
      "type": "local",
      "command": "npx",
      "tools": ["*"],
      "args": ["-y", "@scope/mcp-package", "arg1"]
    }
  }
}
```

### Plugins

Copilot CLI supports plugins for specialized capabilities. Install them with:

```
/install plugin-name
```

Check available plugins in the Copilot CLI plugin marketplace.
