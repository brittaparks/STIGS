<#
.SYNOPSIS
    Disables the Windows lock screen camera by setting the 'NoLockScreenCamera' Group Policy registry key.

.NOTES
    Author          : Britt Parks
    LinkedIn        : linkedin.com/in/brittaparks
    GitHub          : github.com/brittaparks
    Date Created    : 2025-04-12
    Last Modified   : 2025-04-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 2025-04-12
    Tested By       : Britt Parks
    Systems Tested  : Windows 10 Pro, Build 22H2
    PowerShell Ver. : 5.1.19041.5737

.USAGE
    Run this script with administrative privileges to apply the required registry setting.

    Example:
        PS C:\> .\WN10-CC-000005.ps1

    What it does:
        - Creates the registry key: HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization (if it doesn't exist)
        - Sets the 'NoLockScreenCamera' DWORD value to 1, disabling the camera on the lock screen

    Requirements:
        - Must be run as Administrator
        - PowerShell 5.1 or later
        - Windows 10 Pro (Tested on Build 22H2)
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000005).ps1 
#>

# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the NoLockScreenCamera DWORD value to 1
Set-ItemProperty -Path $registryPath -Name "NoLockScreenCamera" -Value 1 -Type DWord

Write-Host "NoLockScreenCamera policy has been set successfully."
