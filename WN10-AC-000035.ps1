<#
.SYNOPSIS
    Configures the minimum password length on the local system.
    Aligns with STIG ID: WN10-AC-000035

.DESCRIPTION
    This script sets the minimum password length to 14 characters using net accounts.

.NOTES
    Author          : Britt Parks
    LinkedIn        : linkedin.com/in/brittaparks
    GitHub          : github.com/brittaparks
    Date Created    : 2025-04-13
    Last Modified   : 2025-04-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000035

.TESTED ON
    Date(s) Tested  : 2025-04-13
    Tested By       : Britt Parks
    Systems Tested  : Windows 10 Pro, Build 22H2
    PowerShell Ver. : 5.1.19041.5737

.USAGE
    Run this script with administrative privileges to apply the required password policy.

    Example:
        PS C:\> .\WN10-AC-000035.ps1

    What it does:
        - Uses `net accounts` to set the minimum password length to 14

    Requirements:
        - Must be run as Administrator
        - PowerShell 5.1 or later
        - Windows 10 Pro (Tested on Build 22H2)
#>

# Set minimum password length using net accounts
try {
    Write-Host "[*] Setting minimum password length to 14..." -ForegroundColor Cyan
    net accounts /minpwlen:14
    Write-Host "[+] Minimum password length successfully set to 14 characters." -ForegroundColor Green
} catch {
    Write-Host "[!] Failed to set minimum password length." -ForegroundColor Red
    Write-Host $_.Exception.Message
}
