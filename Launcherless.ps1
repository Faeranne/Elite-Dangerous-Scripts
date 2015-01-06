$info =  Get-WmiObject Win32_Process -Filter "name = 'EliteDangerous32.exe'"

if ($info) {

    $token = $info.CommandLine -split "ServerToken"
    $desktop = [Environment]::GetFolderPath("Desktop")
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($desktop + '\Elite Launcherless.lnk')
    $Shortcut.TargetPath = $info.Path
    $Shortcut.Arguments = '"ServerToken ' + $token[1]
    $Shortcut.WorkingDirectory = $info.Path | Split-Path
    $Shortcut.Save()

    'Done!'
} else {
    'Error: Launch Elite Dangerous first.'
}
