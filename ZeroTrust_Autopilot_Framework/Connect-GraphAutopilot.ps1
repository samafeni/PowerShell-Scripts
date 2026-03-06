# ============================================================
# Connect-GraphAutopilot.ps1
# Purpose: Connect to Microsoft Graph and retrieve
#          Windows Autopilot device information
# ============================================================

Write-Host "=== Microsoft Graph Autopilot Connection ===" -ForegroundColor Cyan

# Check if Microsoft Graph module exists
if (-not (Get-Module -ListAvailable -Name Microsoft.Graph)) {

    Write-Host "Microsoft.Graph module not found. Installing..." -ForegroundColor Yellow
    Install-Module Microsoft.Graph -Scope CurrentUser -Force

}

# Import module
Import-Module Microsoft.Graph

# Connect to Microsoft Graph
Write-Host "Connecting to Microsoft Graph..." -ForegroundColor Yellow

Connect-MgGraph -Scopes `
"Device.Read.All",
"DeviceManagementConfiguration.Read.All",
"DeviceManagementServiceConfig.Read.All"

# Show connected account
Write-Host "--- Graph Connection Context ---" -ForegroundColor Green
Get-MgContext

# Retrieve Autopilot devices
Write-Host "--- Retrieving Autopilot Devices ---" -ForegroundColor Cyan

$devices = Get-MgDeviceManagementWindowsAutopilotDeviceIdentity |
Select-Object SerialNumber, Model, Manufacturer, DeploymentProfileAssignmentStatus

# Display devices
$devices

# Export to CSV report
$reportPath = ".\AutopilotDevices_Report.csv"

$devices | Export-Csv -Path $reportPath -NoTypeInformation

Write-Host "Report exported to: $reportPath" -ForegroundColor Green

Write-Host "=== Script Complete ===" -ForegroundColor Cyan