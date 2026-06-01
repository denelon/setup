# PSConf.eu 2026 — Configuration as Code for the Workstation

Demo materials from **Demitrius Nelon's PSConf.eu 2026 talk** (Tue 2026-06-02, 15:00 CEST, Wiesbaden).

## What's here

Each subfolder is a self-contained, runnable WinGet configuration. Fork the repo (or just this folder), clone, then:

```pwsh
winget configure .\.config\configuration.winget
```

Or run directly from GitHub without cloning:

```pwsh
winget configure https://raw.githubusercontent.com/denelon/setup/main/psconfeu/2026/devbox-b-tuned/.config/configuration.winget
```

Or open the folder in VS Code and hit **F5** if the WinGet Configure extension is wired up.

### Subfolders

- **`devbox-b-tuned/`** — PowerShell-developer workstation flavor. **Mostly native `dscv3` resources for fast apply**, with one pragmatic exception called out on stage:
  - `Microsoft.VSCode.Dsc/VSCodeExtension` is a **v2 (adapted) resource** — it pays the adapter cost, but it's the right tool for installing VS Code extensions today.

### Configuration files

| File | Purpose |
|------|---------|
| `.config/configuration.winget` | Apply the desired workstation state (install packages, configure settings) |
| `.config/reset.winget` | Undo — removes installed packages to restore the box for a fresh demo run |

**Reset the box** (removes VS Code, Git, GitHub CLI, PowerToys, Oh My Posh, Sysinternals — leaves PowerShell modules intact):

```pwsh
winget configure .\.config\reset.winget
```

Or directly from GitHub:

```pwsh
winget configure https://raw.githubusercontent.com/denelon/setup/main/psconfeu/2026/devbox-b-tuned/.config/reset.winget
```

### Design notes

- **Idempotent by design** — resources use `Microsoft.DSC.Transitional/PowerShellScript` with explicit `testScript`/`setScript` so `winget configure test` accurately reports desired state without unnecessary work on repeat runs.
- **Native v3 resources** — `Microsoft.WinGet/Package`, `OhMyPosh/*`, `Microsoft/OSInfo`, and `Microsoft.WinGet/UserSettingsFile` are all native dscv3 (fast, no adapter overhead).
- **`Install-PSResource`** — all module installs use PSResourceGet (ships with PowerShell 7.4+, no extra dependencies).

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
