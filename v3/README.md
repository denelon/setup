# WinGet Configuration — DSC v3

This directory contains WinGet Configuration files using the **dscv3 processor** (DSC schema v0.3).

## Files

| File | Description |
|------|-------------|
| `denelon.winget` | Workstation configuration (v3/dscv3 schema) — currently a raw export, curation pending |

## Schema

v3 configurations use the dscv3 processor with a flat `resources` array:

```yaml
# yaml-language-server: $schema=https://aka.ms/configuration-dsc-schema/0.3
$schema: https://raw.githubusercontent.com/PowerShell/DSC/main/schemas/2023/08/config/document.json
metadata:
  winget:
    processor:
      identifier: "dscv3"
resources:
- name: winget_Git.Git
  type: Microsoft.WinGet/Package
  metadata:
    description: "Install Git.Git"
  properties:
    id: "Git.Git"
    source: "winget"
```

### Key Differences from v2

| Aspect | v2 | v3 |
|--------|----|----|
| Schema | `configurationVersion: 0.2` | `processor: dscv3` in metadata |
| Structure | `properties.resources[].resource` | `resources[].type` |
| Settings | `settings:` block | `properties:` block |
| Directives | `directives.securityContext` | `metadata.winget.securityContext` |
| Dependencies | `dependsOn` with resource IDs | `dependsOn` with resource names |

## Running

```powershell
winget configure <path-to-file>
# or directly from GitHub:
winget configure https://raw.githubusercontent.com/denelon/setup/refs/heads/main/v3/denelon.winget
```

> **Note:** Running v3 configurations requires WinGet 1.12+ with dscv3 processor support.

## Migration

To convert a v2 configuration to this format, see the [v2 to v3 migration guide](../docs/v2-to-v3-migration.md).
