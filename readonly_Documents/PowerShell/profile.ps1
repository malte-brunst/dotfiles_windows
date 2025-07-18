# Alias
New-Alias g git

# Functions
#. .\my_functions.ps1

# Oh My Posh
$env:Path += ";$env:USERPROFILE\AppData\Local\Programs\oh-my-posh\bin"
if ($IsWindows -or $null -eq $IsWindows) {
    oh-my-posh init pwsh --config "$env:USERPROFILE\Documents\Oh-my-posh\my_oh_my_posh_theme.json" | Invoke-Expression
}
elseif ($IsLinux) {
    oh-my-posh init pwsh --config "${HOME}/Repositories/System/main/Configurations/Oh-my-posh/my_oh_my_posh_theme.json" | Invoke-Expression
}

# PSFzf
$env:Path += ";$env:USERPROFILE\bin"
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -PSReadlineChordSetLocation 'Alt+c'

# Komorebi
[Environment]::SetEnvironmentVariable("KOMOREBI_CONFIG_HOME", "$Env:USERPROFILE\.komorebi", "User")
$Env:KOMOREBI_CONFIG_HOME = "$Env:USERPROFILE\.komorebi"
$env:KOMOREBI_AHK_EXE = "$env:LOCALAPPDATA\Programs\AutoHotkey\v2\AutoHotkey64.exe"
