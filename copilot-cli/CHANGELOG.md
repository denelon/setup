# Changelog

All notable changes to the Copilot CLI setup guide are documented here.

This changelog helps you follow the evolution of the guide and adopt new improvements as they're published.

## 2026-05-07

### Added

- **Multi-device safety workflow** — New section documenting the risk of stale-file overwrites when editing instructions across multiple machines. Includes a copy-paste template rule, failure scenario table, and explanation of the pull→edit→push pattern.
- **"Choose Your Clone Location" step** — The guide no longer assumes a specific path (like `D:\GitHub`). Users are prompted to choose their own clone location upfront, and the guide uses a `<repos>` placeholder throughout.
- **Initial public release** — Published the setup guide, README with a suggested prompt, and this changelog to `denelon/setup/copilot-cli/`.
