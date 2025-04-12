<#
.SYNOPSIS
    Sets the 'Reset account lockout counter after' security policy to 15 minutes, in compliance with STIG ID WN10-AC-000015.

.DESCRIPTION
    This script modifies the local security policy to ensure that the counter for failed logon attempts resets
    after 15 minutes. This helps mitigate brute-force attacks and aligns the system with security hardening
    requirements defined by DISA STIG WN10-AC-000015.

.NOTES
    Author          : Britt Parks
    LinkedIn        : linkedin.com/in/brittaparks
    GitHub          : github.com/brittaparks
    Date Created    : 2025-04-12
    Last Modified   : 2025-04-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000015

.TESTED ON
    Date(s) Tested  : 2025-04-12
    Tested By       : Britt Parks
    Systems Tested  : Windows 10 Pro, Build 22H2
    PowerShell Ver. : 5.1.19041.5737

.USAGE
    Run this script with administrative privileges to apply the required security setting.

    Example:
        PS C:\> .\WN10-AC-000015.ps1

    What it does:
        - Exports the current local security policy
        - Modifies the 'Reset account lockout counter after' value to 15 minutes
        - Applies the updated policy using secedit

    Requirements:
        - Must be run as Administrator
        - PowerShell 5.1 or later
        - Windows 10 Pro (Tested on Build 22H2)
#>

# Define temp INF file path
$infPath = "$env:TEMP\secpol.inf"

# Export current security settings
secedit /export /cfg $infPath

# Read the file, update the line if it exists, or add it
$content = Get-Content $infPath

if ($content -match "ResetLockoutCount") {
    $content = $content -replace "ResetLockoutCount\s*=\s*\d+", "ResetLockoutCount = 15"
} else {
    $index = $content.IndexOf("[System Access]")
    if ($index -ge 0) {
        $insertIndex = $content.IndexOf("", $index)
        $content = $content[0..$insertIndex] + @("ResetLockoutCount = 15") + $content[($insertIndex+1)..($content.Length - 1)]
    }
}

# Save the modified settings
$content | Set-Content $infPath

# Apply the new security settings
secedit /configure /db secedit.sdb /cfg $infPath /quiet

Write-Host "'Reset account lockout counter after' has been set to 15 minutes successfully."
