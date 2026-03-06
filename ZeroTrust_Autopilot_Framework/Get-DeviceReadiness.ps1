# ============================================================
# Get-DeviceReadiness.ps1
# Purpose: Check if this device meets Windows 11 and
#          Autopilot requirements
# ============================================================

Write-Host '=== Device Readiness Check ===' -ForegroundColor Cyan

# Check Windows edition
Write-Host '--- Edition ---' -ForegroundColor Yellow
try {
    Get-WindowsEdition -Online | Select-Object Edition
} catch {
    Write-Host "Unable to get Windows edition: $($_.Exception.Message)" -ForegroundColor Red
}

# Check Windows version and build
Write-Host '--- Version ---' -ForegroundColor Yellow
Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' |
    Select-Object ProductName, DisplayVersion, CurrentBuild

# Check TPM status
Write-Host '--- TPM ---' -ForegroundColor Yellow
try {
    Get-Tpm | Select-Object TpmPresent, TpmReady, TpmEnabled
} catch {
    Write-Host "Unable to get TPM status: $($_.Exception.Message)" -ForegroundColor Red
}

# Check Secure Boot
Write-Host '--- Secure Boot ---' -ForegroundColor Yellow
try {
    $sb = Confirm-SecureBootUEFI
    Write-Host "Secure Boot Enabled: $sb" -ForegroundColor Green
} catch {
    Write-Host "Secure Boot check failed or not supported: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host '=== Check Complete ===' -ForegroundColor Cyan