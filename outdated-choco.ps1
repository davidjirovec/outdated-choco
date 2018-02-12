$ErrorActionPreference = "Stop"
Import-Module -Name BurntToast

$outdated = (choco outdated | Select-Object -Skip 4 | Select-String '^([^|]+)\|.*$').Matches.Groups | Where-Object {$_.Name -eq 1} | ForEach-Object {$_.Value}
$pretty = ($outdated -join ', ')

If ($outdated.count -gt 0) {
    New-BurntToastNotification -Text "Outdated chocolatey packages", "$pretty"
}