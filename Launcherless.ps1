'Powershell version: ' + $PSVersionTable.PSVersion.Major

$info =  Get-WmiObject Win32_Process -Filter "name = 'EliteDangerous32.exe'"

$process = Get-Process EliteDangerous32

if ($info) {

    $token = $info.CommandLine -split "ServerToken"
    $desktop = [Environment]::GetFolderPath("Desktop")
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($desktop + '\Elite Launcherless.lnk')
    $Shortcut.TargetPath = $process.Path
    $Shortcut.Arguments = '"ServerToken ' + $token[1]
    $Shortcut.WorkingDirectory = $process.Path | Split-Path
    $Shortcut.Save()

    'Done!'
} else {
    'Error: Launch Elite Dangerous first.'
}
