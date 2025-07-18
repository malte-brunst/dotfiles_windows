# Copy all files from the PowerShell directory into the WindowsPowerShell directory
$sourceDir = '..\PowerShell'
$destinationDir = Get-Location

Get-ChildItem -Path $sourceDir -File | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $destinationDir
}
