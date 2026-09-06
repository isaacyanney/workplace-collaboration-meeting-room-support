<#
.SYNOPSIS
Validates a synthetic meeting-room inventory without connecting to any device or service.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$InventoryPath,
    [Parameter()][string]$OutputPath = ".\output\inventory-validation.json"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$required = @("RoomId","Location","Capacity","Platform","DisplayCount","Camera","AudioDevice","Connection","SupportTier")
$allowedPlatforms = @("Teams","Zoom","Bring-Your-Own-Device")
$rows = @(Import-Csv -Path $InventoryPath)
if ($rows.Count -eq 0) { throw "Inventory contains no rooms." }

$missing = @($required | Where-Object { $_ -notin $rows[0].PSObject.Properties.Name })
if ($missing.Count -gt 0) { throw "Missing columns: $($missing -join ', ')" }

$findings = foreach ($row in $rows) {
    $messages = [System.Collections.Generic.List[string]]::new()
    if ($row.RoomId -notmatch "^DEMO-RM-[0-9]{3}$") { $messages.Add("RoomId must use the synthetic DEMO format") }
    if ($row.Platform -notin $allowedPlatforms) { $messages.Add("Unsupported platform") }
    if ([int]$row.Capacity -lt 1) { $messages.Add("Capacity must be positive") }
    if ([int]$row.DisplayCount -lt 1) { $messages.Add("At least one display is required") }

    [pscustomobject]@{
        RoomId = $row.RoomId
        ValidationPassed = $messages.Count -eq 0
        Messages = @($messages)
    }
}

$report = [pscustomobject]@{
    SchemaVersion = "1.0"
    Environment = "Synthetic practice framework"
    ConnectedToDevicesOrServices = $false
    RoomCount = $rows.Count
    PassedCount = @($findings | Where-Object ValidationPassed).Count
    Findings = @($findings)
}

$directory = Split-Path -Parent $OutputPath
if ($directory -and -not (Test-Path $directory)) { New-Item -ItemType Directory -Path $directory -Force | Out-Null }
$report | ConvertTo-Json -Depth 6 | Set-Content -Path $OutputPath -Encoding UTF8
Write-Output $report
