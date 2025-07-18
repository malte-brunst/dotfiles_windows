function GitCloneBareForWorktrees {
    param (
        $Url,
        $DirectoryName
    )
    # Examples of call:
    # git-clone-bare-for-worktrees git@github.com:name/repo.git
    # => Clones to a /repo directory
    #
    # git-clone-bare-for-worktrees git@github.com:name/repo.git my-repo
    # => Clones to a /my-repo directory
    New-Item -ItemType Directory -Path $DirectoryName
    Set-Location $DirectoryName

    # Moves all the administrative git files (a.k.a $GIT_DIR) under .bare directory.
    #
    # Plan is to create worktrees as siblings of this directory.
    # Example targeted structure:
    # .bare
    # main
    # new-awesome-feature
    # hotfix-bug-12
    # ...
    git clone --bare $Url .bare

    Write-Output "gitdir: ./.bare" > .git

    # Explicitly sets the remote origin fetch so we can fetch remote branches
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

    # Gets all branches from origin
    git fetch origin

}