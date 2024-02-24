# Overview

I want to be able to run a single WinGet configuration by passing in the URL to my configuration file like:

```
winget configure https://raw.githubusercontent.com/microsoft/denelon/main/denelon.dsc.yaml
```

This should result in making Windows feel like home with all my favorite apps and settings.

Some of the things I want setup below might be listed in more than one place. I'm not sure if it makes more sense to have them in one particular DSC Resource as opposed to another.

>**Note:** My thinking will be influenced by how `winget export` should work in the future so I could make changes to my local device and simply check the new configuration into my setup repository.

## Things I want setup on my Windows PC

Oh-My-Posh
- Nerd Font
- jandedobbeleer theme

PowerShell 7
- WinGet Argument Completer
- Oh-My-Posh
- Modules
  - Microsoft.WinGet.Client
  - Microsoft.WinGet.Configuration
  - Terminal-Icons

Fonts
- CascaydiaCove Nerd Font (cool Glyphs 😊)

WinGet
- Rainbow Progress Bar

wingetcreate

Visual Studio Code
- YAML extension

NuGet

Postman

Git
- denelon/winget-cli
- denelon/winget-pkgs
- denelon/winget-create
- denelon/winget-cli-restsource
- denelon/devhome
- denelon/setup

GitHub Desktop

Dev Drive
- D: Dev Drive 50 GB

File Explorer
- Show Extensions
- Show Hidden Files and Folders

Windows Settings
- Developer Mode Enabled

Windows Features
- Windows Sandbox

WSL
- Ubuntu

ScreenToGif

PowerToys
- Command Not Found Enabled
- Mouse Without Borders Enabled (no secrets in configuration file)

## Gaps and potential workarounds
* WinGet CLI is in a packaged process so when WindowsOptionalFeature is used, the DISM APIs aren't reachable.
  * Use Get-WinGetConfiguration | Invoke-WinGetConfiguration
* Elevation issues
  * Use two configuration files. One required authentication, the other doesn't require (or prohibits elevation)
