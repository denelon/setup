# WinGet Configuration — DSC v2

This directory contains WinGet Configuration files using the **DSC schema v0.2** (also called "v2").

## Files

| File | Description |
|------|-------------|
| `denelon.winget` | Curated workstation configuration (v2 schema) |

## Schema

v2 configurations use `configurationVersion: 0.2` and the `properties.resources` structure:

```yaml
# yaml-language-server: $schema=https://aka.ms/configuration-dsc-schema/0.2
properties:
  configurationVersion: 0.2
  resources:
  - resource: Microsoft.WinGet.DSC/WinGetPackage
    directives:
      description: "Install Git"
    settings:
      id: "Git.Git"
      source: "winget"
```

## Running

```powershell
winget configure <path-to-file>
# or directly from GitHub:
winget configure https://raw.githubusercontent.com/denelon/setup/refs/heads/main/v2/denelon.winget
```

## Migration

To convert this configuration to DSC v3 format, see the [v2 to v3 migration guide](../docs/v2-to-v3-migration.md).
