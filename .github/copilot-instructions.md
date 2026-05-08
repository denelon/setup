# Copilot Instructions for `denelon/setup`

## Project Purpose

This is a **public reference repository** for workstation configuration as code using WinGet Configuration. It demonstrates both v2 (schema 0.2) and v3 (dscv3 processor) patterns and serves as the demo repo for PSConf.eu 2026.

## Repository Structure

```
v2/          — Curated v2 configuration (schema 0.2)
v3/          — Curated v3 configuration (dscv3 schema)
docs/        — Guides: lifecycle, migration, ecosystem wishlist
copilot-cli/ — Public Copilot CLI setup guide (synced from private repo)
```

## Configuration Philosophy

- **Configs are runnable as-is** on Demitrius's machines — not templates with placeholders.
- **Curated, not exported** — only intentional packages and settings. Never include transitive dependencies (VCRedist, UI.Xaml, VCLibs, DotNet runtimes, etc.).
- **v2 and v3 must stay in sync** — both configs represent the same workstation intent. When a package is added or removed from one, update the other to match. v3 may have additional settings resources (WinGet User/Admin Settings, Windows Settings, WinGetCreate Settings) that have no v2 equivalent — those are additive, not a divergence.
- **Dependency chains are explicit** — resources that depend on another being installed first must use `dependsOn` in v3 (e.g., WinGetCreate Settings depends on WingetCreate package).

## v3 Configuration Conventions

- Resource `name` fields should be descriptive: `winget_<PackageId>` for packages, `<Type>-<index>` for settings.
- Packages requiring elevation use `metadata.winget.securityContext: "elevated"`.
- Group resources by purpose with YAML comments: Schema/metadata, Settings, Windows Settings, Packages.
- The `Microsoft.WinGet/Package` type replaces `Microsoft.WinGet.DSC/WinGetPackage` from v2.
- WinGet font source is implicit — do NOT specify `source: "font"`. The msstore source MUST be explicit (`source: "msstore"`).
- Fonts require elevated install for Windows Terminal to detect them.

### Available DSC v3 Resources (beyond WinGet)

- **PowerToys:** `Microsoft.PowerToys/<UtilityName>Settings` — per-utility settings. Note: MouseWithoutBorders, PowerLauncher, and NewPlus are intentionally excluded from v3 (sensitive/non-portable config).
- **Oh-My-Posh:** `OhMyPosh/Font`, `OhMyPosh/Config`, `OhMyPosh/Shell`
- **WinGetCreate:** `Microsoft.WinGetCreate/Settings`
- **OSInfo:** `Microsoft/OSInfo` (get/export only — assertions on family, edition, architecture; version is exact match only)

## v2 Configuration Conventions

- Uses `properties.assertions` for pre-flight checks (OS version).
- Uses `properties.resources` with `directives.securityContext: elevated` for elevation.
- Resource type is `Microsoft.WinGet.DSC/WinGetPackage`.
- The v2 config is the **historical reference** and should not gain features that can't be expressed in schema 0.2.

## Documentation

- `docs/wishlist.md` tracks **ecosystem gaps** — missing DSC resources, WinGet features, or platform limitations that prevent ideal configurations. It does NOT track personal to-do items.
- `docs/my-setup.md` is the **intent document** — describes everything Demitrius wants configured on his machines (apps, settings, customizations). This is the source of truth for what the v2 and v3 configs should contain. When a config is updated, this doc must be updated to match, and vice versa.
- `docs/config-as-code.md` documents the generic lifecycle: Export → Curate → Extend → Test → Maintain.
- `docs/v2-to-v3-migration.md` provides conversion guidance. Cross-references `microsoft/winget-dsc` docs but does not duplicate them.
- The root `README.md` has an Improvements section tracking upstream issues we're waiting on (e.g., PowerShell/DSC#1521).

## Cross-References

- **`microsoft/winget-dsc`** — link to its docs for DSC resource details and conversion tooling. Do not duplicate content from that repo here.
- **PowerShell/DSC#1521** — OSInfo min-version assertion. Tracked in README Improvements table.

## What NOT to Put Here

- PSConf.eu-specific presentation content (stays in private prep).
- Personal/proprietary information — this repo is public.
- Raw exports — always curate before committing.
- Transitive dependencies or packages the user didn't intentionally choose.

## PR and Commit Conventions

- **Always create draft PRs** — never mark a PR as ready for review. Demitrius will review and promote it himself.
- After creating a PR, provide the full clickable URL so Demitrius can review it on GitHub.
- Keep commits focused: one logical change per commit.
- PR descriptions should explain what changed and why (especially for config curation decisions).
