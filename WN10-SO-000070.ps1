<#
.SYNOPSIS
    Configures the machine inactivity limit to 15 minutes (900 seconds), complying with STIG ID WN10-SO-000070.

.DESCRIPTION
    This script sets the 'InactivityTimeoutSecs' registry value to 900 seconds (15 minutes) under the System policies. This enforces automatic locking of the workstation after the specified period of inactivity, enhancing security by preventing unauthorized access when the user is away.

.NOTES
    Author          : Britt Parks
    LinkedIn        : linkedin.com/in/brittaparks
    GitHub          : github.com/brittaparks
    Date Created    : 2025-04-13
    Last Modified   : 2025-04-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000070

.TESTED ON
    Date(s) Tested  : 2025-04-13
    Tested By       : Britt Parks
    Systems Tested  : Windows 10 Pro, Build 22H2
    PowerShell Ver. : 5.1.19041.5737

.USAGE
    Run this script with administrative privileges to apply the required security setting.

    Example:
        PS C:\> .\WN10-SO-000070.ps1

    What it does:
        - Creates the registry key: HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System (if it doesn't exist)
        - Sets the 'InactivityTimeoutSecs' DWORD value to 900, enforcing a 15-minute inactivity timeout

    Requirements:
        - Must be run as Administrator
        - PowerShell 5.1 or later
        - Windows 10 Pro (Tested on Build 22H2)
#>

# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the InactivityTimeoutSecs DWORD value to 900 (15 minutes)
Set-ItemProperty -Path $registryPath -Name "InactivityTimeoutSecs" -Value 900 -Type DWord

Write-Host "'InactivityTimeoutSecs' has been set to 900 seconds (15 minutes) successfully."
