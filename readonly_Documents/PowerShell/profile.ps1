# Alias
New-Alias g git

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
[Environment]::SetEnvironmentVariable('KOMOREBI_CONFIG_HOME', "$Env:USERPROFILE\.komorebi", 'User')
$Env:KOMOREBI_CONFIG_HOME = "$Env:USERPROFILE\.komorebi"
$env:KOMOREBI_AHK_EXE = "$env:LOCALAPPDATA\Programs\AutoHotkey\v2\AutoHotkey64.exe"

# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Functions
function GitCloneBareForWorktrees {
    param (
        [string]$Url,
        [string]$DirectoryName
    )

    # If DirectoryName is not provided, derive it from the URL
    if (-not $DirectoryName) {
        $BaseName = ($Url -split '/')[-1]
        $DirectoryName = $BaseName -replace '\.git$', ''
    }

    # Create the target directory and switch to it
    New-Item -ItemType Directory -Path $DirectoryName -Force *>$null
    Set-Location $DirectoryName

    # Clone the repository as bare into .bare
    git clone --bare $Url .bare

    # Create .git file pointing to .bare
    'gitdir: ./.bare' | Set-Content .git

    # Set remote origin fetch to get all branches
    git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'

    # Fetch all branches from origin
    git fetch origin

}

function GitInitBareForWorktrees {
    # Init a normal repo because with Windows on git, you can only run git config --global inside of a git repository
    git init *>$null
    # Get globally configured user name and email
    $globalUserName = git config --global user.name
    $globalUserEmail = git config --global user.email
    # Remove the git repository again
    Remove-Item -Path .\.git -Recurse -Force

    Write-Host "Current global user name: $globalUserName"
    Write-Host "Current global user email: $globalUserEmail"

    $customUserName = Read-Host 'Do you want to use a custom name for the initial commit? (leave empty for default)'
    $customUserEmail = Read-Host 'Do you want to use a custom email for the initial commit? (leave empty for default)'

    $finalUserName = if ($customUserName) { $customUserName } else { $globalUserName }
    $finalUserEmail = if ($customUserEmail) { $customUserEmail } else { $globalUserEmail }

    # Initialize a bare repository
    git init --bare .bare
    'gitdir: ./.bare' | Set-Content .git

    # Create an initial commit in a temporary working directory
    $parent = [System.IO.Path]::GetTempPath()
    $name = [System.IO.Path]::GetRandomFileName()
    $tempWorktree = Join-Path $parent $name
    New-Item -ItemType Directory -Path $tempWorktree *>$null

    # Set user name and email just for this commit
    $env:GIT_AUTHOR_NAME = $finalUserName
    $env:GIT_AUTHOR_EMAIL = $finalUserEmail
    $env:GIT_COMMITTER_NAME = $finalUserName
    $env:GIT_COMMITTER_EMAIL = $finalUserEmail

    git --git-dir=.bare --work-tree=$tempWorktree commit --allow-empty -m 'Initial commit' *>$null

    # Set user name and email locally for the repository only if custom values are provided
    if ($customUserName) {
        git config --file .bare/config user.name $finalUserName
    }
    if ($customUserEmail) {
        git config --file .bare/config user.email $finalUserEmail
    }

    # Clean up the temporary working directory
    Remove-Item -Recurse -Force $tempWorktree

    # Create the worktree for the main branch
    git worktree add ./main *>$null
}


function GitDestroyWorktree {
    param (
        [string]$WorktreeName
    )

    if (-not $WorktreeName) {
        Write-Error "Worktree name (param 'WorktreeName') is required."
        return
    }

    # Removes the worktree with name $WorktreeName
    git worktree remove $WorktreeName *>$null

    # Removes remote branch with name $WorktreeName on origin (if exists)
    git push origin --delete $WorktreeName *>$null

    # Removes local branch with name $WorktreeName (if exists)
    git branch -D $WorktreeName *>$null
}
