# My Setup

What I want configured on my Windows machines. This is the source of truth — the v2 and v3 configuration files should reflect this intent.

## Packages

All packages should be installed at the **latest available version**.

| Package ID | Purpose |
|------------|---------|
| Git.Git | Version control |
| Microsoft.PowerShell | Shell |
| JanDeDobbeleer.OhMyPosh | Prompt theming |
| Microsoft.PowerToys | Productivity utilities |
| GitHub.GitHubDesktop | Git GUI |
| Element.Element | Matrix client |
| Microsoft.VisualStudioCode | Editor |
| Microsoft.WingetCreate | Manifest authoring |
| Microsoft.WindowsApp | Windows App (RDP client) |
| Microsoft.Edit | Terminal-based editor |
| Microsoft.WinGetStudio | WinGet Studio GUI |
| GitHub.Copilot | Copilot CLI |
| Microsoft.WSL | Windows Subsystem for Linux |
| Canonical.Ubuntu.2404 | Ubuntu 24.04 LTS (WSL distro) |

## WinGet User Settings

- Progress bar: rainbow
- Sixels: enabled
- Downloader: wininet

## WinGet Admin Settings

All security settings locked down:
- LocalManifestFiles: false
- ProxyCommandLineOptions: false
- BypassCertificatePinningForMicrosoftStore: false
- InstallerHashOverride: false
- LocalArchiveMalwareScanOverride: false

## Windows Settings

- Developer Mode: enabled
- System color mode: Light
- App color mode: Light
- Taskbar alignment: Middle

## WinGetCreate Settings

- Telemetry: enabled
- Manifest format: yaml
- Repository: microsoft/winget-pkgs
- Cleanup: every 7 days
- Anonymize paths: true

## Dev Drive

- Drive letter: D:
- Size: 100 GB
- File system: ReFS
- Label: Dev Drive

## Oh-My-Posh Configuration

- Font: CascaydiaCove Nerd Font — via `OhMyPosh/Font` (v3) or `winget install` from font source
- Theme: jandedobbeleer — via `OhMyPosh/Config`
- Shell integration — via `OhMyPosh/Shell`

> **Notes:**
> - WinGet has a built-in `font` source for Nerd Fonts. Do NOT specify `source: "font"` explicitly — it's implicit. Fonts require **elevated** install for Windows Terminal to detect them.
> - For packages from the Microsoft Store, specify `source: "msstore"` explicitly.

## PowerToys Configuration

- Find My Mouse: enabled — via `Microsoft.PowerToys/FindMyMouseSettings` (v3) / `FindMyMouse` (v2)
- Mouse Without Borders: enabled — via `MouseWithoutBorders` (v2 only; intentionally excluded from v3 due to sensitive config values)
- WinGet Command Not Found: enabled — via `Microsoft.DSC.Transitional/RunCommandOnSet` (v3) / `PSDscResources/Script` (v2) to install module from PSGallery and add `Import-Module` to `$PROFILE`

## Windows Optional Features

- Windows Sandbox (`Containers-DisposableClientVM`): enabled
- Hyper-V (`Microsoft-Hyper-V-All`): enabled

> **Note:** These may require a reboot. In v3, uses `Microsoft.Windows/OptionalFeatureList`. In v2, uses `PSDscResources/WindowsOptionalFeature`.

## Git Clone — Public Forks

Clone all public WinGet forks to `D:\GitHub` via `GitDsc/GitClone` (PSGallery, prerelease).

| Repository | URL |
|-----------|-----|
| winget-cli | `https://github.com/denelon/winget-cli.git` |
| winget-pkgs | `https://github.com/denelon/winget-pkgs.git` |
| winget-create | `https://github.com/denelon/winget-create.git` |
| winget-cli-restsource | `https://github.com/denelon/winget-cli-restsource.git` |
| winget-dsc | `https://github.com/denelon/winget-dsc.git` |
| winget-command-not-found | `https://github.com/denelon/winget-command-not-found.git` |
| winget-studio | `https://github.com/denelon/winget-studio.git` |
| setup | `https://github.com/denelon/setup.git` |

> **Not included (private):** winget-pkgs-preprod, mxc, copilot-instructions

> **Ecosystem gap:** `GitDsc` requires the PowerShell adapter. Git should ship a native DSC v3 command-based resource — see wishlist.
