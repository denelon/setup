# Workstation Configuration as Code

A guide to managing your Windows workstation setup as a declarative, version-controlled configuration using [WinGet Configuration](https://learn.microsoft.com/windows/package-manager/configuration/).

## Why Configuration as Code?

Instead of manually installing apps and tweaking settings every time you set up a new machine (or rebuild an existing one), you define your desired state in a YAML file. WinGet Configuration then:

- **Installs your apps** — via WinGet packages
- **Configures settings** — Windows settings, app settings, developer mode, etc.
- **Sets up your environment** — Dev Drives, PowerShell modules, VS Code extensions
- **Is idempotent** — running it again skips what's already done

The result: a single file (or set of files) that represents "what my machine should look like."

## The Lifecycle

### 1. Export — Start from your current machine

```powershell
winget configure export -o my-config.winget
```

This generates a raw export of everything WinGet knows about your machine — installed packages, settings, etc. It's a starting point, not a finished config.

### 2. Curate — Make it intentional

The raw export includes everything — dependencies, pre-installed system components, things you didn't deliberately install. Curation means:

- **Remove noise** — VCRedist, UI.Xaml, and other framework dependencies that come in transitively
- **Remove pre-installed packages** — Things like Edge, Teams, or OneDrive that ship with Windows (unless you want to pin a version)
- **Organize by purpose** — Group packages logically (dev tools, communication, utilities)
- **Add descriptions** — Make it clear *why* each resource is there
- **Set security contexts** — Mark which packages need elevation

### 3. Extend — Go beyond packages

A curated config isn't just a package list. Add resources for:

- **Windows settings** — Developer mode, color scheme, taskbar alignment
- **App settings** — WinGet settings, Terminal profiles, VS Code configuration
- **Dev Drives** — Automatically create a Dev Drive volume
- **PowerShell modules** — Install modules you depend on
- **Environment setup** — Registry keys, file system structure

### 4. Test — Validate your configuration

```powershell
# Check if your machine matches the desired state (without making changes)
winget configure test <path-to-config>

# Apply the configuration
winget configure <path-to-config>
```

Testing lets you verify what's in/out of compliance without changing anything.

### 5. Maintain — Keep it alive

Your config should evolve with your workflow:

- **Add new tools** as you adopt them
- **Remove packages** you no longer use
- **Update settings** as preferences change
- **Version control it** — commit changes to a Git repo so you can see the history
- **Test periodically** — run `winget configure test` to catch drift

## Getting Started

1. **Export your current state:**
   ```powershell
   winget configure export -o my-export.winget
   ```

2. **Review and curate** — Open the file, remove noise, organize by purpose

3. **Store in a Git repo** — Create a repo (public or private) and commit your config

4. **Run on a new machine:**
   ```powershell
   winget configure https://raw.githubusercontent.com/<you>/<repo>/main/<path>.winget
   ```

## Schema Versions

WinGet Configuration supports two schema versions:

| Version | Schema | Processor | Status |
|---------|--------|-----------|--------|
| v2 | `configurationVersion: 0.2` | PowerShell DSC | Stable, widely supported |
| v3 | `processor: dscv3` | DSC v3 (cross-platform) | Current, recommended for new configs |

Both are fully supported. If you have an existing v2 config, see the [v2 to v3 migration guide](v2-to-v3-migration.md) for how to convert.

## Tips

- **Start small.** Don't try to capture everything on day one. Start with your top 10 apps and expand from there.
- **Test on a VM or fresh install.** Before trusting your config for a real setup, validate it somewhere safe.
- **Use comments.** YAML supports `#` comments — use them to explain groupings and decisions.
- **Keep a raw export for reference.** Your curated config is intentional; the raw export shows what you might be missing.
- **Share it.** Public configs help others learn the pattern. Private configs keep proprietary tools/settings hidden.

## Further Reading

- [WinGet Configuration documentation](https://learn.microsoft.com/windows/package-manager/configuration/)
- [v2 to v3 migration guide](v2-to-v3-migration.md)
- [Example v2 configuration](../v2/)
- [Example v3 configuration](../v3/)
