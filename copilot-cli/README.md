# Copilot CLI — Persistent Instructions Setup

Give GitHub Copilot CLI a persistent memory so it knows your tools, repos, coding style, and conventions across every session, on every machine.

## What This Is

A guide for setting up a **personal, portable Copilot CLI instructions file** that:

- Persists across sessions (no more repeating yourself)
- Syncs across machines via a private Git repo
- Tracks history so you can see how your setup evolves
- Includes multi-device safety so edits on one machine don't overwrite changes from another

## Quick Start

The fastest way to get set up is to **ask Copilot itself to help you.** Open a Copilot CLI session and paste this prompt:

```
I'd like to set up persistent Copilot CLI instructions that sync across my machines.
Walk me through the process described in this guide:
https://github.com/denelon/setup/blob/main/copilot-cli/SETUP-GUIDE.md

Ask me where I keep my Git clones, then help me create a private repo,
write an initial instructions file, and set up the symlink.
```

Copilot will walk you through each step interactively — choosing your clone location, creating the private repo, writing your first instructions file, and symlinking it into place.

## Manual Setup

If you prefer to do it yourself, read the full [SETUP-GUIDE.md](SETUP-GUIDE.md).

## Files in This Directory

| File | Purpose |
|------|---------|
| [SETUP-GUIDE.md](SETUP-GUIDE.md) | Complete step-by-step guide |
| [CHANGELOG.md](CHANGELOG.md) | History of improvements to this guide |
| README.md | This file |

## FAQ

**Q: Is my instructions file public?**
No. The instructions file lives in your own *private* repo. This guide only explains the *pattern* — your personal content stays private.

**Q: Does this work on macOS/Linux?**
Yes. The guide includes instructions for all platforms.

**Q: What if I use multiple machines?**
The guide includes a [Multi-Device Safety](SETUP-GUIDE.md#multi-device-safety) section specifically for this. It prevents Copilot from accidentally overwriting changes made on another device.

**Q: What should I put in my instructions file?**
Start small — your name, role, preferred tools, and a few guardrails. Then grow it over time. The guide has a [full table of suggested sections](SETUP-GUIDE.md#sections-that-work-well).

## Related

- [WinGet Configuration](../README.md) — The rest of this repo covers setting up a Windows machine with WinGet Configuration files.
