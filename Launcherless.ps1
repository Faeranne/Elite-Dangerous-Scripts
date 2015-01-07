'Powershell version: ' + $PSVersionTable.PSVersion.Major

$info =  Get-WmiObject Win32_Process -Filter "name = 'EliteDangerous32.exe'"

$path = $info.Path
#Override with a verbatim path in quotes if path is empty, like so:
#$path = 'C:\Program Files (x86)\Frontier\EDLaunch\Products\FORC-FDEV-D-1003\EliteDangerous32.exe'

if ($info) {

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
