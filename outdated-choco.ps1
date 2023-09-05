$ErrorActionPreference = "Stop"
Import-Module -Name BurntToast

# Get the list of pinned packages
$pinnedPackages = (choco pin list -r | ForEach-Object { $_.Split('|')[0] }).Trim()

# Get the list of outdated packages and filter out the pinned ones
$outdated = (choco outdated -r | Select-String '^([^|]+)\|.*$').Matches.Groups | Where-Object {$_.Name -eq 1} | ForEach-Object {$_.Value} | Where-Object { $_ -notin $pinnedPackages }

$pretty = ($outdated -join ', ')

If ($outdated.count -gt 0) {
    New-BurntToastNotification -Text "Outdated chocolatey packages", "$pretty"
}
