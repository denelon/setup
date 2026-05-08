# WinGet Configuration Ecosystem Wishlist

Gaps in the WinGet/DSC ecosystem that prevent ideal configuration-as-code workflows. These are upstream limitations — not personal to-do items.

## DSC Resource Gaps

| Gap | Impact | Tracking |
|-----|--------|----------|
| `Microsoft/OSInfo` lacks min-version assertion | Cannot assert "Windows 11 22H2 or later" — only exact version match | [PowerShell/DSC#1521](https://github.com/PowerShell/DSC/issues/1521) |
| No native Dev Drive resource in DSC v3 | Must use `RunCommandOnSet` workaround or `StorageDsc` (v2 only) | — |
| No PowerShell module configuration resource | Cannot declaratively install PS modules or set up `$PROFILE` content | — |
| No native Git DSC v3 resource | `GitDsc` (winget-dsc) works via PowerShell adapter but Git should ship a native command-based v3 resource | — |
| No File Explorer settings resource | Cannot set "show extensions" or "show hidden files" declaratively | — |

## WinGet Feature Gaps

| Gap | Impact | Tracking |
|-----|--------|----------|
| `winget export` captures transitive dependencies | Exports include VCRedist, UI.Xaml, VCLibs — requires manual curation | — |
| No VS Code extension management in config | Cannot declaratively install extensions via WinGet Configuration | — |
| Resume-after-reboot not fully working | WSL install requires reboot before Ubuntu can be installed; experimental `resume` feature doesn't reliably continue configuration | — |

## Resolved

| Gap | Resolution |
|-----|-----------|
| ~~Mixed elevation~~ | Now supported in WinGet Configuration files |
| ~~No font installation resource~~ | `OhMyPosh/Font` DSC v3 resource |
| ~~No Oh-My-Posh theme/config resource~~ | `OhMyPosh/Config` and `OhMyPosh/Shell` DSC v3 resources |
| ~~No PowerToys settings resource~~ | `Microsoft.PowerToys/*` DSC v3 resources (per-utility) |
| ~~No Windows Optional Features resource in v3~~ | `Microsoft.Windows/OptionalFeatureList` (v0.1.0) — native DISM-based resource |

