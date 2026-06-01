# PSConf.eu 2026 — Configuration as Code for the Workstation

Demo materials from **Demitrius Nelon's PSConf.eu 2026 talk** (Tue 2026-06-02, 15:00 CEST, Wiesbaden).

## What's here

Each subfolder is a self-contained, runnable WinGet configuration. Fork the repo (or just this folder), clone, then:

```pwsh
winget configure .\.config\configuration.winget
```

Or open the folder in VS Code and hit **F5** if the WinGet Configure extension is wired up.

### Subfolders

- **`devbox-b-tuned/`** — PowerShell-developer workstation flavor. **Mostly native `dscv3` resources for fast apply**, with one pragmatic exception called out on stage:
  - `Microsoft.VSCode.Dsc/VSCodeExtension` is a **v2 (adapted) resource** — it pays the adapter cost, but it's the right tool for installing VS Code extensions today.

## Prerequisites

Fresh Windows 11 ships with an older WinGet. On a clean box:

1. Open Microsoft Store → update apps → updates the **App Installer** package → WinGet now current stable.
2. `winget configure --enable` (one-time, brings in DSC v3).
3. From there, `winget configure` against any file in this folder.

## Talk references

- Slides + recording: _(link after the talk)_
- Project notes (canonical): see [`docs/`](../../docs/) in this repo
- Companion samples: <https://github.com/microsoft/winget-dsc/tree/main/samples>
- WinGet Studio: <https://github.com/microsoft/winget-studio>

## Convention

These configs live at `<folder>/.config/configuration.winget`, the [Microsoft Learn convention for Git-based projects](https://learn.microsoft.com/windows/package-manager/configuration/). That convention is what enables the **Fork → Clone → WinGet Configure → F5** flow shown in the talk.
