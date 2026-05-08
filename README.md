# Workstation Configuration as Code with WinGet

Declarative workstation setup using [WinGet Configuration](https://learn.microsoft.com/windows/package-manager/configuration/). Define your apps, settings, and environment in a YAML file — then apply it to any machine.

## Quick Start

```powershell
# Apply the v3 configuration directly from GitHub
winget configure https://raw.githubusercontent.com/denelon/setup/refs/heads/main/v3/denelon.winget
```

Or clone the repo and run locally:

```powershell
git clone https://github.com/denelon/setup.git
winget configure .\setup\v3\denelon.winget
```

## Repository Structure

```
├── v2/                     DSC v2 (schema 0.2) configuration
│   ├── denelon.winget      Curated workstation config
│   └── README.md           v2 schema notes and usage
├── v3/                     DSC v3 (dscv3 processor) configuration
│   ├── denelon.winget      Workstation config (curation pending)
│   └── README.md           v3 schema notes and usage
├── docs/                   Guides and documentation
│   ├── config-as-code.md   Lifecycle: Export → Curate → Extend → Test → Maintain
│   └── v2-to-v3-migration.md   Converting v2 configs to v3
├── copilot-cli/            Setting up persistent Copilot CLI instructions
└── README.md               This file
```

## Documentation

| Guide | Description |
|-------|-------------|
| [Configuration as Code](docs/config-as-code.md) | The full lifecycle of managing your workstation as a declarative config |
| [v2 to v3 Migration](docs/v2-to-v3-migration.md) | Converting existing DSC v2 configs to the dscv3 processor format |
| [Copilot CLI Setup](copilot-cli/README.md) | Persistent Copilot CLI instructions that sync across machines |

## What's Configured

The configurations in this repo set up a development workstation with:

- **Dev Drive** — 100 GB ReFS volume for source code
- **Developer tools** — Git, PowerShell 7, VS Code, GitHub Desktop, Azure CLI
- **Utilities** — PowerToys, Oh My Posh, WinGet Create
- **Windows settings** — Developer mode, color scheme, taskbar alignment
- **App settings** — WinGet settings, WinGet Create settings

## Schema Versions

This repo maintains configurations in both DSC v2 and v3 formats:

| Version | Directory | Status |
|---------|-----------|--------|
| DSC v2 | [`v2/`](v2/) | Stable — uses `configurationVersion: 0.2` |
| DSC v3 | [`v3/`](v3/) | Current — uses dscv3 processor |

New configurations should use v3. To convert an existing v2 config, see the [migration guide](docs/v2-to-v3-migration.md) or use the [`winget-config-v2-to-v3`](https://github.com/microsoft/winget-dsc) Copilot CLI skill.

## Assumptions

- Windows 11 (works on new installs or existing builds with Dev Drive support)
- C:\ can be shrunk by 100 GB to create a Dev Drive
- D:\ will be the Dev Drive

## Improvements

Tracked issues that would improve these configurations:

| Issue | Description |
|-------|-------------|
| [PowerShell/DSC#1521](https://github.com/PowerShell/DSC/issues/1521) | `Microsoft/OSInfo`: Support minimum version assertion (>= comparison) — needed for fast OS version pre-flight checks in v3 configs |

## Related

- [WinGet Configuration docs](https://learn.microsoft.com/windows/package-manager/configuration/)
- [microsoft/winget-dsc](https://github.com/microsoft/winget-dsc) — DSC resources, v3 samples, and conversion guide
- [microsoft/winget-cli](https://github.com/microsoft/winget-cli) — WinGet client
