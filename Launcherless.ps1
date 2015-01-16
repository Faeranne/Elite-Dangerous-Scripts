if ($PSVersionTable.PSVersion.Major -lt 3) {
  Write-Host "Powershell 3 or higher is required, please follow link [1] in the description" -ForegroundColor Red
  exit
}

$info =  Get-WmiObject Win32_Process -Filter "name = 'EliteDangerous32.exe'"

$path = $info.Path

if ($info) {

    if (!$path) {
        Write-Host "Failed to get the path to the executable from the process" -ForegroundColor Red
        Write-Host "Please copy and paste the full path to the EliteDangerous32.exe here and press Enter" -ForegroundColor Red
        Write-Host "Example > D:\Games\EDLaunch\Products\FORC-FDEV-D-1003\EliteDangerous32.exe" -ForegroundColor Red
        $path = Read-Host "Fullpath > "
    }

    $token = $info.CommandLine -split "ServerToken"
    $desktop = [Environment]::GetFolderPath("Desktop")
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($desktop + '\Elite Launcherless.lnk')
    $Shortcut.TargetPath = $path
    $Shortcut.Arguments = '"ServerToken ' + $token[1]
    $Shortcut.WorkingDirectory = $path | Split-Path
    $Shortcut.Save()

    'Done!'
} else {
    Write-Host 'Error: Launch Elite Dangerous first.' -ForegroundColor Red
}
