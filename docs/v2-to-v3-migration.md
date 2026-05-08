# Migrating WinGet Configuration from DSC v2 to DSC v3

This guide explains how to convert an existing WinGet Configuration file from the DSC v0.2 schema ("v2") to the dscv3 processor schema ("v3").

## Why Migrate?

DSC v3 is the current recommended schema for new WinGet configurations:

- **Cross-platform foundation** — Built on the new [DSC v3 engine](https://github.com/PowerShell/DSC) (Rust-based, cross-platform)
- **Simplified structure** — Flatter YAML, fewer nested layers
- **Better performance** — Resource evaluation can be significantly faster for certain resource types
- **Active development** — New features and resources target v3 first

## Key Structural Changes

### Document Root

**v2:**
```yaml
# yaml-language-server: $schema=https://aka.ms/configuration-dsc-schema/0.2
properties:
  configurationVersion: 0.2
  resources:
  - resource: Microsoft.WinGet.DSC/WinGetPackage
    ...
```

**v3:**
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
  ...
```

### Resource Declaration

| Field | v2 | v3 |
|-------|----|----|
| Resource type | `resource: Microsoft.WinGet.DSC/WinGetPackage` | `type: Microsoft.WinGet/Package` |
| Resource name | `id: winget_Git.Git` (in directives) | `name: winget_Git.Git` (top-level) |
| Description | `directives.description` | `metadata.description` |
| Settings/Properties | `settings:` block | `properties:` block |
| Security context | `directives.securityContext: elevated` | `metadata.winget.securityContext: "elevated"` |
| Dependencies | `dependsOn: [resource_id]` | `dependsOn: [- resource_name]` |

### Resource Type Mapping

| Purpose | v2 Resource | v3 Resource |
|---------|-------------|-------------|
| Install a package | `Microsoft.WinGet.DSC/WinGetPackage` | `Microsoft.WinGet/Package` |
| WinGet user settings | `Microsoft.WinGet.DSC/WinGetUserSettings` | `Microsoft.WinGet/UserSettingsFile` |
| WinGet admin settings | `Microsoft.WinGet.DSC/WinGetAdminSettings` | `Microsoft.WinGet/AdminSettings` |
| Windows settings | `Microsoft.Windows.Developer/...` | `Microsoft.Windows.Settings/WindowsSettings` |
| Run a command | `PSDscResources/Script` | `Microsoft.DSC.Transitional/RunCommandOnSet` |

### Example: Single Package

**v2:**
```yaml
- resource: Microsoft.WinGet.DSC/WinGetPackage
  id: winget_Git.Git
  directives:
    description: "Install Git.Git"
    securityContext: elevated
  settings:
    id: "Git.Git"
    source: "winget"
```

**v3:**
```yaml
- name: winget_Git.Git
  type: Microsoft.WinGet/Package
  metadata:
    description: "Install Git.Git"
    winget:
      securityContext: "elevated"
  properties:
    id: "Git.Git"
    source: "winget"
```

## Migration Methods

### Method 1: Copilot CLI Skill (Recommended)

The `winget-config-v2-to-v3` Copilot CLI skill can convert your configuration interactively:

1. Open a Copilot CLI session in the directory containing your v2 config
2. Ask: "Convert my v2 WinGet Configuration to v3"
3. Copilot will read your file and produce the v3 equivalent

The skill handles all structural transformations, resource type mapping, and metadata reorganization.

### Method 2: Fresh Export + Curation

If your v2 config is outdated anyway, start fresh:

```powershell
# Export current machine state in v3 format
winget configure export -o my-export-v3.winget
```

Then curate the export using the [configuration as code lifecycle](config-as-code.md#2-curate--make-it-intentional).

### Method 3: Manual Conversion

Follow the structural changes above to convert each resource by hand. Best for small configs or when you want to understand every change.

## Conversion Reference

For detailed samples, a complete conversion guide, and DSC v3 resource examples, see the [`microsoft/winget-dsc`](https://github.com/microsoft/winget-dsc) repository:

- [DscResources samples](https://github.com/microsoft/winget-dsc/tree/main/DscResources) — v3 resource usage examples
- [Conversion guide](https://github.com/microsoft/winget-dsc) — Comprehensive v2→v3 migration documentation

## Common Pitfalls

| Issue | Solution |
|-------|----------|
| `allowPrerelease` not working | In v3, use `-AllowPrerelease` in RunCommandOnSet for module installs, not a directive flag |
| Resources running without elevation | Move `securityContext` from `directives` to `metadata.winget.securityContext` |
| Dependencies not resolving | Ensure `dependsOn` references use the `name` field value, not `id` |
| Settings resource not found | Resource type names changed (see mapping table above) |

## Further Reading

- [WinGet Configuration documentation](https://learn.microsoft.com/windows/package-manager/configuration/)
- [DSC v3 schema reference](https://github.com/PowerShell/DSC)
- [Workstation Configuration as Code guide](config-as-code.md)
