# Demitrius Nelon's WinGet Configuration
This is where I will work on building a WinGet Configuration designed to get Windows to feel like home.

My goal is to get to a pure WinGet configuration with zero work-arounds. I'll call out things where gaps exist and I'll link those things to issues at GitHub in the appropriate repositories to track progress as I work to close the gaps.

# Assumptions
* New computer with Windows 11 (This should also work on an existing Windows 11 build with Dev Drive support)
* C:\ can be shrunk by 100 gigs to create a Dev Drive
* D:\ will be the Dev Drive

# Running the configuration
1. Open Windows PowerShell
2. Run `winget configure https://raw.githubusercontent.com/denelon/setup/refs/heads/main/denelon.winget`


# Improvements
* [Support mixed elevation requirements in configuration files](https://github.com/microsoft/winget-cli/issues/4353)
