$mypath = $MyInvocation.MyCommand.Path
Write-Output "Path of the script: $mypath"
Write-Output "Args for script: $Args"

# Turn off progress bar to make Invoke-WebRequest faster
$ProgressPreference = 'SilentlyContinue'

# WinGet (App Installer) isn't registered or the latest stable version on First Login
$isWinGetRecent = (winget -v).Trim('v').TrimEnd("-preview").split('.')

# Turn off progress bar to make invoke WebRequest faster
$ProgressPreference = 'SilentlyContinue'

# WinGet is greater than v1 or v1.6 or higher
if(!(($isWinGetRecent[0] -gt 1) -or ($isWinGetRecent[0] -ge 1 -and $isWinGetRecent[1] -ge 6))) 
{
   $paths = "Microsoft.VCLibs.x64.14.00.Desktop.appx", "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle", "Microsoft.UI.Xaml.2.7.x64.appx"
   $uris = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx", "https://aka.ms/getwinget", "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx"
   Write-Host "Downloading WinGet and its dependencies..."

   for ($i = 0; $i -lt $uris.Length; $i++) {
       $filePath = $paths[$i]
       $fileUri = $uris[$i]
       Write-Host "Downloading: ($filePat) from $fileUri"
       Invoke-WebRequest -Uri $fileUri -OutFile $filePath
   }

   Write-Host "Installing WinGet and its dependencies..."
   
   foreach($filePath in $paths)
   {
       Write-Host "Installing: ($filePath)"
       Add-AppxPackage $filePath
   }

   Write-Host "Verifying Version number of WinGet"
   winget -v

   Write-Host "Cleaning up"
   foreach($filePath in $paths)
   {
      if (Test-Path $filePath) 
      {
         Write-Host "Deleting: ($filePath)"
         Remove-Item $filePath -verbose
      } 
      else
      {
         Write-Error "Path doesn't exits: ($filePath)"
      }
   }
}
else {
   Write-Host "WinGet in decent state, moving to executing DSC"
}

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

$dscUri = "https://raw.githubusercontent.com/denelon/setup/main/"
$dscNonAdmin = "denelon.user.dsc.yaml";
$dscAdmin = "denelon.admin.dsc.yaml";

$dscNonAdminUri = $dscUri + $dscNonAdmin 
$dscAdminUri = $dscUri + $dscAdmin

# amazing, we can now run WinGet get fun stuff
if (!$isAdmin) {
   # love tap terminal to it gets registered moving foward
   Start-Process shell:AppsFolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App

   Invoke-WebRequest -Uri $dscNonAdminUri -OutFile $dscNonAdmin 
   winget configure -f $dscNonAdmin 
   
   # clean up, Clean up, everyone wants to clean up
   Remove-Item $dscNonAdmin -verbose

   # restarting for Admin now
	Start-Process PowerShell -wait -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$mypath' $Args;`"";
	exit;
}
else {
   # admin section now
   Invoke-WebRequest -Uri $dscAdminUri -OutFile $dscAdmin 
   winget configure -f $dscAdmin 
   
   # clean up, Clean up, everyone wants to clean up
   Remove-Item $dscAdmin -verbose
}
